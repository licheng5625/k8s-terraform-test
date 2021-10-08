import socket
import logging
from random import randrange
import time
HOST = '10.99.30.227'  # The server's hostname or IP address
PORT = 6000       # The port used by the server
while True:
    sleepTime = randrange(10)
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.connect((HOST, PORT))
        s.sendall( str.encode("Hello, world " + str(sleepTime)))
        data = s.recv(1024)
    time.sleep(sleepTime)

    logging.info("Received %s" %(repr(data)))
