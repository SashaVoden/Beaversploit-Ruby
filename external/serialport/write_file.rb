require 'serialport'

port = SerialPort.new("/dev/ttyUSB0", 9600, 8, 1, SerialPort::NONE)

print "File"
filename = gets.chomp

print "Text/script "
content = gets.chomp

port.write("WRITE_FILE #{filename} #{content}\r\n")
puts "writed #{filename}"
port.close