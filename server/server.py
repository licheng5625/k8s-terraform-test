import socket
import threading
import time
import logging
def tcplink(connect, addr):
    logging.warning("Connected by %s" %( addr[0]))
    while True:
        data = connect.recv(1024)
        time.sleep(1)
        if not data:
            break
        logging.warning("Device: %s, Data: %s" %(addr[0], data) )
        connect.sendall(data)
    connect.close()

if __name__ == "__main__":
    ser = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    HOST = '0.0.0.0'  # Standard loopback interface address (localhost)
    PORT = 5000        # Port to listen on (non-privileged ports are > 1023)
    ser.bind((HOST, PORT))
    ser.listen(10)
    logging.error('Start running at %s' %(socket.gethostbyname(socket.gethostname())))

    while True:
        sock, addr = ser.accept()
        ptheard = threading.Thread(target=tcplink( connect=sock, addr = addr))