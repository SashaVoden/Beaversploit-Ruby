require 'resolv'

class DnsLookup
  attr_accessor :options

  def initialize
    @options = { "domain" => "" }
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
    puts "\n[DnsLookup Options]"
    @options.each { |k, v| puts "#{k.ljust(12)}: #{v}" }
    puts ""
  end

  def run
    domain = @options["domain"]
    if domain.strip.empty?
      puts "[-] Domain not set. Use 'set domain <value>' to set it."
      return
    end
    puts "\n[DnsLookup] Resolving domain #{domain}..."
    begin
      ip = Resolv.getaddress(domain)
      puts "[*] Domain #{domain} resolved to #{ip}"
    rescue => e
      puts "[!] Error: #{e.message}"
    end
    puts "[DnsLookup] Execution completed.\n"
  end
end