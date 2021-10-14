defmodule BwKafka do

  use Broadway

  alias Broadway.Message

  def start_link(_opts) do
    Broadway.start_link(__MODULE__,
      name: __MODULE__,
      producer: [
        module:
          {BroadwayKafka.Producer,
           [
             hosts: [localhost: 9092],
             group_id: "group_1",
             topics: ["test1"]
           ]},
        concurrency: 2
      ],
      processors: [
        default: [
          concurrency: 4 
        ]
      ],
      batchers: [
        default: [
          batch_size: 1000,
          batch_timeout: 5000,
          concurrency: 2
        ]
      ]
    )
  end

  @impl true
  def handle_message(_, message, _) do
    message
    |> Message.update_data(&process_data/1)
  end

  @impl true
  def handle_batch(_, messages, _, _) do
    list = messages |> Enum.map(fn e -> e.data end)
    #IO.inspect(list, label: "Got batch")
    hdfs(list)
    messages
  end

  defp process_data(data) do
    IO.inspect(data, label: "Got message")
  end

  defp hdfs(message) do
    name = "test-" <> Integer.to_string(:os.system_time(:millisecond))
    {:ok, response } = HTTPoison.put("http://localhost:50070/webhdfs/v1/tmp/test/#{name}?user.name=hadoop&op=CREATE") 
    {"Location", path} = List.keyfind(response.headers,"Location",0) 
    HTTPoison.put(path,message,[],[])
  end


end
