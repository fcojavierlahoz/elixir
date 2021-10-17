import Config 

config :bw_kafka,
  hosts: "localhost:9092",
  group: "group_1",
  topics: "test1",
  producers: 2,
  processors: 4,
  batchers: 2


