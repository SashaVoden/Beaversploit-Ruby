require 'socket'
require 'timeout'

class PortScan
  attr_accessor :options

  def initialize
    @options = { "IP" => "", "start_port" => "1", "end_port" => "100" }
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
    puts "\n[PortScan Options]"
    @options.each { |k, v| puts "#{k.ljust(12)}: #{v}" }
    puts ""
  end

  def run
    ip = @options["IP"]
    start_port = @options["start_port"].to_i
    end_port = @options["end_port"].to_i
    if ip.strip.empty?
      puts "[-] IP address not set. Use 'set IP <value>' to set it."
      return
    end
    puts "\n[PortScan] Scanning ports on #{ip} from #{start_port} to #{end_port}..."
    (start_port..end_port).each do |port|
      begin
        Timeout.timeout(1) do
          socket = TCPSocket.new(ip, port)
          socket.close
          puts "[+] Port #{port} is open."
        end
      rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH, Timeout::Error
        puts "[-] Port #{port} is closed."
      rescue => e
        puts "[!] Error on port #{port}: #{e.message}"
      end
    end
    puts "[PortScan] Scanning completed.\n"
  end
end