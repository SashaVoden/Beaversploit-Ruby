require 'net/http'
require 'uri'

class DownloadExecute
  attr_accessor :options

  def initialize
    @options = { "URL" => "" }
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
    puts "\n[DownloadExecute Options]"
    @options.each { |k, v| puts "#{k.ljust(12)}: #{v}" }
    puts ""
  end

  def run
    url = @options["URL"]
    if url.strip.empty?
      puts "[-] URL not set. Use 'set URL <value>' to set it."
      return
    end
    puts "\n[DownloadExecute] Simulating download and execution of payload from #{url}..."
    begin
      uri = URI.parse(url)
      response = Net::HTTP.get_response(uri)
      if response.code.to_i == 200
        puts "[*] Download successful. Executing payload (simulation)..."
        sleep(2)
        puts "[*] Payload executed (simulation)."
      else
        puts "[-] Failed to download payload. HTTP Code: #{response.code}"
      end
    rescue => e
      puts "[!] Error: #{e.message}"
    end
    puts "[DownloadExecute] Execution completed.\n"
  end
end