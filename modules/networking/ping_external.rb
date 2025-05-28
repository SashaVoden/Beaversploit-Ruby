require 'net/ping'

class PingExternal
  def initialize(target = nil, count = 4, timeout = 1)
    @target  = target
    @count   = count.to_i
    @timeout = timeout.to_f
  end

  def run
    if @target.nil? || @target.strip.empty?
      print "Enter target IP or hostname for external ping: "
      @target = gets.strip
    end

    puts "[*] Starting external ping to #{@target} for #{@count} packets (timeout #{@timeout}s)"
    pinger = Net::Ping::External.new(@target, @timeout)
    @count.times do
      start_time = Time.now
      if pinger.ping?
        duration = ((Time.now - start_time) * 1000).round(2)
        puts "[+] External ping response from #{@target}: time=#{duration} ms"
      else
        puts "[-] External ping to #{@target} failed (timeout/error)"
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
    when "timeout"
      @timeout = value.to_f
    else
      puts "[-] Unknown option '#{option}'"
    end
  end

  def show_options
    puts "Target: #{@target || 'not set'}"
    puts "Count: #{@count}"
    puts "Timeout: #{@timeout}"
  end
end