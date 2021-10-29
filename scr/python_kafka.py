from time import sleep
from json import dumps
from kafka import KafkaProducer
import sys

numRegisters = 100
if (len(sys.argv) > 1):
    numRegisters = int(sys.argv[1])

producer = KafkaProducer(bootstrap_servers=['localhost:9092'],
                         value_serializer=lambda x: 
                         dumps(x).encode('utf-8'))
for e in range(numRegisters):
    data = "number: "+str(e)
    producer.send('test1', value=data)

producer.close()
