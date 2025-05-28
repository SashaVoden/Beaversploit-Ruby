class WhoisLookup
  def initialize(domain = nil)
    @domain = domain
  end

  def run
    if @domain.nil? || @domain.strip.empty?
      print "Enter domain for WHOIS lookup (e.g., example.com): "
      @domain = gets.strip
    end

    puts "[*] Running WHOIS lookup for #{@domain}..."
    begin
      result = `whois #{@domain}`
      puts result
    rescue => e
      puts "[-] Error performing WHOIS lookup: #{e.message}"
    end
  end

  def set_option(option, value)
    if option.downcase == "domain"
      @domain = value
    else
      puts "[-] Unknown option: #{option}"
    end
  end

  def show_options
    puts "Domain: #{@domain || 'not set'}"
  end
end