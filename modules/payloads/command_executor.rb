class CommandExecutor
  attr_accessor :options

  def initialize
    @options = { "CMD" => "" }
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
    puts "\n[CommandExecutor Options]"
    @options.each { |k, v| puts "#{k.ljust(12)}: #{v}" }
    puts ""
  end

  def run
    cmd = @options["CMD"]
    if cmd.strip.empty?
      puts "[-] CMD not set. Use 'set CMD <value>' to set it."
      return
    end
    puts "\n[CommandExecutor] Simulating execution of command: #{cmd}"
    sleep(1)
    puts "[*] Command executed (simulation)."
    puts "[CommandExecutor] Execution completed.\n"
  end
end