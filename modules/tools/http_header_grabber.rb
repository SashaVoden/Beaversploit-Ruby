require 'net/http'
require 'uri'

class HttpHeaderGrabber
  attr_accessor :options

  def initialize
    @options = { "url" => "http://example.com" }
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
    puts "\n[HttpHeaderGrabber Options]"
    @options.each { |k, v| puts "#{k.ljust(12)}: #{v}" }
    puts ""
  end

  def run
    url = @options["url"]
    if url.strip.empty?
      puts "[-] URL not set. Use 'set url <value>' to set it."
      return
    end
    puts "\n[HttpHeaderGrabber] Fetching HTTP headers for #{url}..."
    begin
      uri = URI.parse(url)
      response = Net::HTTP.get_response(uri)
      puts "[*] HTTP Headers:"
      response.each_header { |header, value| puts "#{header}: #{value}" }
    rescue => e
      puts "[!] Error: #{e.message}"
    end
    puts "[HttpHeaderGrabber] Execution completed.\n"
  end
end