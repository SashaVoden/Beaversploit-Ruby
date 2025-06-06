require 'serialport'

port = SerialPort.new("/dev/ttyUSB0", 9600, 8, 1, SerialPort::NONE)

print "Filename "
filename = gets.chomp

port.write("DOWNLOAD_FILE #{filename}\r\n")
sleep 1
data = port.read

File.write("downloads/#{filename}", data)
puts "File #{filename} downloaded"
port.close