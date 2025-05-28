class PasswordCracker
  attr_accessor :options

  def initialize
    @options = { "hash" => "", "method" => "bruteforce" }
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
    puts "\n[PasswordCracker Options]"
    @options.each { |k, v| puts "#{k.ljust(12)}: #{v}" }
    puts ""
  end

  def run
    hash = @options["hash"]
    method = @options["method"]
    if hash.strip.empty?
      puts "[-] Hash not set. Use 'set hash <value>' to set it."
      return
    end
    puts "\n[PasswordCracker] Cracking hash using #{method} method..."
    sleep 2
    puts "[*] Simulated cracked password: 'password123'"
    puts "[PasswordCracker] Cracking completed.\n"
  end
end