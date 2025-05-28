class HostDiscovery
  attr_accessor :options

  def initialize
    @options = { "subnet" => "192.168.1.", "start_ip" => "1", "end_ip" => "254", "timeout" => "1" }
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
    puts "\n[HostDiscovery Options]"
    @options.each { |k, v| puts "#{k.ljust(12)}: #{v}" }
    puts ""
  end

  def run
    subnet = @options["subnet"]
    start_ip = @options["start_ip"].to_i
    end_ip = @options["end_ip"].to_i
    timeout = @options["timeout"].to_i
    puts "\n[HostDiscovery] Scanning subnet #{subnet} for hosts from #{start_ip} to #{end_ip}..."
    (start_ip..end_ip).each do |i|
      ip = "#{subnet}#{i}"
      result = `ping -c 1 -W #{timeout} #{ip} 2>/dev/null`
      if result.include?("1 received") || result.include?("1 packets received")
        puts "[+] Host #{ip} is up."
      else
        puts "[-] Host #{ip} is down."
      end
    end
    puts "[HostDiscovery] Scanning completed.\n"
  end
end