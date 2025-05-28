require 'net/http'
require 'uri'

class XSSScanner
  def initialize(url = nil)
    @url = url
    @payloads = ['<script>alert(1)</script>', '" onmouseover="alert(1)"', "'><img src=x onerror=alert(1)>"]
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
      if response.body.include?(payload)
        puts "[!] Potential XSS vulnerability detected with payload: #{payload}"
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