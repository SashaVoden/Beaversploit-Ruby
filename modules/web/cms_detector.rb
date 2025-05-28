require 'net/http'
require 'uri'

class CMSDetector
  def initialize(url = nil)
    @url = url
  end
  
  def run
    if @url.nil? || @url.strip.empty?
      print "Enter target URL (e.g., https://example.com): "
      @url = gets.strip
    end
    uri = URI(@url)
    uri.scheme = "https"
    uri.port   = 443

    begin
      response = Net::HTTP.get_response(uri)
      html = response.body

      cms = detect_cms(html)
      if cms
        puts "[+] Detected CMS: #{cms}"
      else
        puts "[-] No known CMS detected"
      end
    rescue StandardError => e
      puts "[-] Error fetching URL: #{e.message}"
    end
  end

  def detect_cms(content)
    return "WordPress" if content.include?("wp-content") || content.include?("wp-includes") || content.match(/<meta name=["']generator["'] content=["']WordPress/i)
    return "Joomla" if content.include?("index.php?option=com") || content.match(/<meta name=["']generator["'] content=["']Joomla/i)
    return "Drupal" if content.include?("sites/default") || content.match(/<meta name=["']Generator["'] content=["']Drupal/i)
    
    nil
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
  end
end