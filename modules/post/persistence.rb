class Persistence
  attr_accessor :options

  def initialize
    @options = { "host" => "", "method" => "autostart" }
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
    puts "\n[Persistence Options]"
    @options.each { |k, v| puts "#{k.ljust(12)}: #{v}" }
    puts ""
  end

  def run
    host = @options["host"]
    method = @options["method"]
    if host.strip.empty?
      puts "[-] Host not set. Use 'set host <value>' to set it."
      return
    end
    puts "\n[Persistence] Establishing persistence on #{host} using method '#{method}'..."
    if method.downcase == "autostart"
      puts "[*] Simulating adding command to startup..."
    else
      puts "[*] Simulating starting a hidden process..."
    end
    puts "[Persistence] Persistence simulated.\n"
  end
end