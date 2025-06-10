require 'net/ftp'

class FTPAnonymityScanner
  def initialize(host = nil, port = 20, timeout = 1)
    @host = host
    @port = port
    @timeout = timeout
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
      print "Enter FTP host: "
      @host = gets.strip
    end

    begin
      ftp = Net::FTP.new
      ftp.connect(@host, @port)
      ftp.login('anonymous', 'anonymous@domain.com')
      puts "[+] Anonymous login successful on #{@host}:#{@port}"
      ftp.close
    rescue Exception => e
      puts "[-] Failed to login anonymously: #{e.message}"
    end
  end
end