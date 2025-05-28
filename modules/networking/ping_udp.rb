require 'net/ping'

class PingUDP
  def initialize(target = nil, count = 4, port = 80, timeout = 1)
    @target  = target
    @count   = count.to_i
    @port    = port.to_i
    @timeout = timeout.to_f
  end

  def run
    if @target.nil? || @target.strip.empty?
      print "Enter target IP or hostname for UDP ping: "
      @target = gets.strip
    end

    puts "[*] Starting UDP ping to #{@target} on port #{@port} for #{@count} packets (timeout #{@timeout}s)"
    pinger = Net::Ping::UDP.new(@target, @port, @timeout)
    @count.times do
      start_time = Time.now
      if pinger.ping?
        duration = ((Time.now - start_time) * 1000).round(2)
        puts "[+] UDP ping received reply from #{@target}:#{@port} in #{duration} ms"
      else
        puts "[-] UDP ping to #{@target}:#{@port} timed out or error occurred"
      end
      sleep 1
    end
  end

  def set_option(option, value)
    case option.downcase
    when "target"
      @target = value
    when "count"
      @count = value.to_i
    when "port"
      @port = value.to_i
    when "timeout"
      @timeout = value.to_f
    else
      puts "[-] Unknown option '#{option}'"
    end
  end

  def show_options
    puts "Target: #{@target || 'not set'}"
    puts "Port: #{@port}"
    puts "Count: #{@count}"
    puts "Timeout: #{@timeout}"
  end
end