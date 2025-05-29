require 'net/ping'

class SpamPing
  def initialize
    @target = nil
    @interval = 0.01
    @packet_size = 20
  end

  def run
    unless @target
      puts "[-] Target not set! Use 'set target <IP>'"
      return
    end

    puts "[*] Starting constant ping to #{@target} with #{@packet_size}-byte packets every #{@interval}s..."
    pinger = Net::Ping::ICMP.new(@target, nil, @interval)

    loop do
      start_time = Time.now
      if pinger.ping?
        duration = ((Time.now - start_time) * 1000).round(2)
        puts "[+] Reply from #{@target}: time=#{duration} ms, size=#{@packet_size} bytes"
      else
        puts "[-] Request timed out"
      end
      sleep @interval
    end
  end

  def set_option(option, value)
    case option.downcase
    when "target"
      @target = value
    when "interval"
      @interval = value.to_f
    when "packet_size"
      @packet_size = value.to_i
    else
      puts "[-] Unknown option: #{option}"
    end
  end

  def show_options
    puts "Target: #{@target || 'not set'}"
    puts "Interval: #{@interval} sec"
    puts "Packet Size: #{@packet_size} bytes"
  end
end