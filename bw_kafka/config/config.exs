import Config 

config :bw_kafka,
  hosts: "localhost:9092",
  group: "group_1",
  topics: "test1",
  producers: 1,
  processors: 2,
  batchers: 2,
  batch_size: 10000


