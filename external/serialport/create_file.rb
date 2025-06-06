require 'serialport'

port = SerialPort.new("/dev/ttyUSB0", 9600, 8, 1, SerialPort::NONE)

print "Filename "
filename = gets.chomp

port.write("CREATE_FILE #{filename}\r\n")
puts "File #{filename} created"
port.close