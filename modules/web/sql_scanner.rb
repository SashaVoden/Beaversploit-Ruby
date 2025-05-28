require 'net/http'
require 'uri'

class SQLScanner
  def initialize(url = nil)
    @url = url
    @payloads = ["'", "\"", " OR 1=1 --", " UNION SELECT NULL,NULL --"]
  end

  def run
    if @url.nil? || @url.strip.empty?
      print "Enter target URL: "
      @url = gets.strip
    end

    @payloads.each do |payload|
      target_url = "#{@url}?input=#{URI.encode_www_form_component(payload)}"
      uri = URI(target_url)
      response = Net::HTTP.get_response(uri)
      if response.body =~ /syntax error|SQL/
        puts "[!] Potential SQL injection vulnerability detected with payload: #{payload}"
      else
        puts "[+] Payload #{payload} appears safe"
      end
    end
  end

  def set_option(option, value)
    if option.downcase == "url"
      @url = value
    else
      puts "[-] Unknown option: #{option}"
    end
  end

  def show_options
    puts "URL: #{@url || 'not set'}"
    puts "Payloads: #{@payloads.join(', ')}"
  end
end