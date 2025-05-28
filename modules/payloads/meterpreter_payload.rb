class MeterpreterPayload
  attr_accessor :options

  def initialize
    @options = { "LHOST" => "", "LPORT" => "4444", "SessionType" => "reverse_tcp" }
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
    puts "\n[MeterpreterPayload Options]"
    @options.each { |k, v| puts "#{k.ljust(12)}: #{v}" }
    puts ""
  end

  def run
    lhost = @options["LHOST"]
    lport = @options["LPORT"]
    type = @options["SessionType"]
    if lhost.strip.empty?
      puts "[-] LHOST not set. Use 'set LHOST <value>' to set it."
      return
    end
    puts "\n[MeterpreterPayload] Simulating meterpreter payload..."
    puts "[*] Establishing #{type} session from #{lhost}:#{lport}..."
    sleep(2)
    puts "[*] Meterpreter session established (simulation)."
    puts "[MeterpreterPayload] Execution completed.\n"
  end
end