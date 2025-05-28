require 'socket'
require 'timeout'

class BannerGrabber
  attr_accessor :options

  def initialize
    @options = { "IP" => "", "port" => "80", "timeout" => "2" }
  end

  def set_option(option, value)
    key = @options.keys.find { |k| k.downcase == option.strip.downcase }
    if key
      @options[key] = value
      puts "[*] Set #{key} to #{value}"
    else
      puts "[-] Option '#{option}' not found."
    end
  end

  def show_options
    puts "\n[BannerGrabber Options]"
    @options.each { |k, v| puts "#{k.ljust(12)}: #{v}" }
    puts ""
  end

  def run
    ip = @options["IP"]
    port = @options["port"].to_i
    timeout_sec = @options["timeout"].to_i
    if ip.strip.empty?
      puts "[-] IP not set. Use 'set IP <value>' to set it."
      return
    end
    puts "\n[BannerGrabber] Connecting to #{ip}:#{port}..."
    begin
      Timeout.timeout(timeout_sec) do
        socket = TCPSocket.new(ip, port)
        banner = socket.recv(1024)
        socket.close
        puts "[*] Banner: #{banner.strip}"
      end
    rescue => e
      puts "[!] Error: #{e.message}"
    end
    puts "[BannerGrabber] Execution completed.\n"
  end
end