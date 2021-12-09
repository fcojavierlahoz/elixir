defmodule BwKafka do

  @kafka_hosts  Application.fetch_env!(:bw_kafka, :hosts)
  @kafka_group  Application.fetch_env!(:bw_kafka, :group)
  @kafka_topics Application.fetch_env!(:bw_kafka, :topics)
  @kafka_keytab Application.fetch_env!(:bw_kafka, :keytab)
  @kafka_principal Application.fetch_env!(:bw_kafka, :principal)

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
               #sasl: {:plain,"user","password"}
               #sasl: {:callback, :brod_gssapi, {:gssapi, @kafka_keytab, @kafka_principal}},
               #ssl: [cacertfile: "/tmp/test/priv/ca.crt", certfile: "/tmp/test/priv/client.crt", keyfile: "/tmp/test/priv/client.key", password: 'test1234'],
             ] 
           ]},
        concurrency: Application.fetch_env!(:bw_kafka, :producers) 
      ],
      processors: [
        mysql: [
          concurrency: Application.fetch_env!(:bw_kafka, :processors) 
        ]
      ],
      batchers: [
        hdfs: [
          batch_size: Application.fetch_env!(:bw_kafka, :batch_size),
          concurrency: Application.fetch_env!(:bw_kafka, :batchers),
          batch_timeout: 10000,
        ],
        solr: [
          batch_size: 1000,
        ],
        mysql: [
          batch_size: 10000,
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

  def handle_message(:mysql, message, _) do
    message
    |> Message.update_data(&BwKafka.Transform.insert_data/1)
    |> Message.put_batcher(:hdfs)
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

  @impl true
  def handle_batch(:mysql, messages, _, _) do
    IO.inspect "Got Batch Mysql"
    messages
  end

end
