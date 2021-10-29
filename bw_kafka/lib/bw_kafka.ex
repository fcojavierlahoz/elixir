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
             topics: [@kafka_topics],
             client_config: [
               #ssl: true
               #ssl_options: [
               # cacertfile: File.cwd!() <> "/ssl/ca-cert",
               # certfile: File.cwd!() <> "/ssl/cert.pem",
               # keyfile: File.cwd!() <> "/ssl/key.pem"
               # ]
             ] 
           ]},
        concurrency: Application.fetch_env!(:bw_kafka, :producers) 
      ],
      processors: [
        hdfs: [
          concurrency: Application.fetch_env!(:bw_kafka, :processors) 
        ]
      ],
      batchers: [
        hdfs: [
          batch_size: Application.fetch_env!(:bw_kafka, :batch_size),
          concurrency: Application.fetch_env!(:bw_kafka, :batchers),
        ],
        solr: [
          batch_size: 1000,
        ]
      ]
    )
  end

  @impl true
  def handle_message(:hdfs, message, _) do
    message
    |> Message.update_data(&BwKafka.Transform.process_data/1)
    #|> Message.put_batcher(:solr)
    |> Message.put_batcher(:hdfs)
  end

  def handle_message(:solr, message, _) do
    message
    |> Message.put_batcher(:solr)
  end

  @impl true
  def handle_batch(:hdfs, messages, _, _) do
    IO.inspect "Got Batch HDFS"
    messages
    |> BwKafka.Hdfs.put()
    messages
  end

  @impl true
  def handle_batch(:solr, messages, _, _) do
    IO.inspect "Got Batch Solr"
    messages
  end


end
