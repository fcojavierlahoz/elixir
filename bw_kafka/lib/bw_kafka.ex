defmodule BwKafka do

  @kafka_hosts  Application.fetch_env!(:bw_kafka, :hosts)
  @kafka_group  Application.fetch_env!(:bw_kafka, :group)
  @kafka_topics Application.fetch_env!(:bw_kafka, :topics)

  use Broadway
  
  alias Broadway.Message

  def start_link(_opts) do
    Broadway.start_link(__MODULE__,
      name: __MODULE__,
      producer: [
        module:
          {BroadwayKafka.Producer,
           [
             hosts: @kafka_hosts,
             group_id: @kafka_group,
             topics: [@kafka_topics]
           ]},
        concurrency: Application.fetch_env!(:bw_kafka, :producers) 
      ],
      processors: [
        default: [
          concurrency: Application.fetch_env!(:bw_kafka, :processors) 
        ]
      ],
      batchers: [
        default: [
          batch_size: 10000,
          batch_timeout: 5000,
          concurrency: Application.fetch_env!(:bw_kafka, :batchers) 
        ]
      ]
    )
  end

  @impl true
  def handle_message(_, message, _) do
    message
    |> Message.update_data(&BwKafka.Transform.process_data/1)
  end

  @impl true
  def handle_batch(_, messages, _, _) do
    list = messages |> Enum.map(fn e -> e.data <> "\n" end)
    #IO.inspect(list, label: "Got batch")
    BwKafka.Hdfs.put(list)
    messages
  end


end
