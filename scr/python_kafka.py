from time import sleep
from json import dumps
from kafka import KafkaProducer

#producer = KafkaProducer(bootstrap_servers='192.168.200.1:9092')
#producer.send('test1', b'pepe')

producer = KafkaProducer(bootstrap_servers=['localhost:9092'],
                         value_serializer=lambda x: 
                         dumps(x).encode('utf-8'))
for e in range(100000):
    data = {'number' : e}
    producer.send('test1', value=data)

producer.close()
