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
          batch_size: 100,
          batch_timeout: 1000,
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
    IO.inspect(list, label: "Got batch")
    messages
  end

  defp process_data(data) do
    IO.inspect(data, label: "Got message")
  end


end
