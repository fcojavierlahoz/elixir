defmodule BwKafka.Test do

  def start() do

    topic = "test"
    client_id = :my_client
    hosts = [localhost: 9092]

    :ok = :brod.start_client(hosts, client_id, _client_config=[])
    :ok = :brod.start_producer(client_id, topic, _producer_config = [])

    Enum.each(1..1000, fn i ->
      partition = rem(i, 3)
      :ok = :brod.produce_sync(client_id, topic, partition, _key="", "#{i}")
    end)

  end

end
