require 'serialport'

port = SerialPort.new("/dev/ttyUSB0", 9600, 8, 1, SerialPort::NONE)
port.write("LIST_FILES\r\n")
sleep 1
puts port.read
port.close