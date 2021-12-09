from time import sleep
from kafka import KafkaProducer
import sys
import json
import random

numRegisters = 100
if (len(sys.argv) > 1):
    numRegisters = int(sys.argv[1])

producer = KafkaProducer(bootstrap_servers=['localhost:9092'])
for e in range(numRegisters):
    data = {'id': e, 'field1': 'field1'+str(e), 'field2': 'field2'+str(e), 'field3': random.randint(0,e)}
    producer.send('test1', value=json.dumps(data).encode('utf-8'))

producer.close()
