require 'openssl'
require 'socket'
require 'timeout'

class SSLCertChecker
  def initialize(host = nil, port = 443, timeout = 5)
    @host = host
    @port = port.to_i
    @timeout = timeout.to_i
  end

  def set_option(option, value)
    case option.downcase
    when "host"
      @host = value
    when "port"
      @port = value.to_i
    when "timeout"
      @timeout = value.to_i
    else
      puts "[-] Unknown option: #{option}"
    end
  end

  def show_options
    puts "Host: #{@host || 'not set'}"
    puts "Port: #{@port}"
    puts "Timeout: #{@timeout} seconds"
  end

  def run
    if @host.nil? || @host.strip.empty?
      print "Enter target host: "
      @host = gets.strip
    end

    context = OpenSSL::SSL::SSLContext.new
    begin
      Timeout.timeout(@timeout) do
        tcp_socket = TCPSocket.new(@host, @port)
        ssl_socket = OpenSSL::SSL::SSLSocket.new(tcp_socket, context)
        ssl_socket.connect
        cert = ssl_socket.peer_cert
        puts "[+] SSL Certificate Details for #{@host}:#{@port}"
        puts "  Subject: #{cert.subject}"
        puts "  Issuer: #{cert.issuer}"
        puts "  Not Before: #{cert.not_before}"
        puts "  Not After: #{cert.not_after}"
        remaining = cert.not_after - Time.now
        puts "  Expires in: #{(remaining/86400).round} days"
        ssl_socket.sysclose
        tcp_socket.close
      end
    rescue Timeout::Error
      puts "[-] Connection timed out."
    rescue Exception => e
      puts "[-] Error: #{e.message}"
    end
  end
end