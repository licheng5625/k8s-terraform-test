import socket
import os
import logging
from random import randrange
import time
#HOST = 'tcp-service.default.svc.cluster.local'  # The server's hostname or IP address
HOST = os.getenv("HOST_URL", None)
#PORT = 6000       # The port used by the server
PORT = int(os.getenv("HOST_PORT", None))
while True:
    data = None
    sleepTime = randrange(10)
    logging.warning("Try to connecting to " + HOST)
    try:
        ip_addres = socket.gethostbyname(HOST)
    except socket.gaierror:
        logging.error(HOST + " cannot be found")
        time.sleep(sleepTime)
        continue
    logging.warning("Connecting to " + str(ip_addres))
    try:
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            s.connect((HOST, PORT))
            s.sendall( str.encode("Hello, world " + str(sleepTime)))
            data = s.recv(1024)
    except ConnectionRefusedError:
        logging.error("Connection Refused ")
    except TimeoutError:
           logging.error("Connection Time Out   ")

   
    if data is not None:
        logging.warning("Received %s" %(repr(data)))
    time.sleep(sleepTime)
