require 'net/http'
require 'uri'

class DirectoryBruteforce
  def initialize(url = nil, wordlist_file = nil)
    @url = url
    @wordlist_file = wordlist_file || "directories.txt"
  end

  def run
    if @url.nil? || @url.strip.empty?
      print "Enter target URL (e.g., https://example.com): "
      @url = gets.strip
    end

    unless @url.start_with?("https://")
      @url = "https://" + @url.gsub(/^http:\/\//, "")
    end

    unless File.exist?(@wordlist_file)
      puts "[-] Wordlist file '#{@wordlist_file}' not found."    
      return
    end

    words = File.readlines(@wordlist_file).map(&:strip)
    puts "[*] Starting directory bruteforce on #{@url}..."

    words.each do |word|
      target = URI.join(@url, "#{word}/").to_s
      begin
        target_uri = URI(target)
        target_uri.scheme = "https"
        target_uri.port = 443
        
        response = Net::HTTP.get_response(target_uri)
        if response.code.to_i != 404
          puts "[+] Found directory: #{target} (HTTP #{response.code})"
        end
      rescue => e
        puts "[-] Error accessing #{target}: #{e.message}"
      end
    end
    puts "[*] Directory bruteforce completed."
  end

  def set_option(option, value)
    case option.downcase
    when "url"
      @url = value
    when "wordlist_file"
      @wordlist_file = value
    else
      puts "[-] Unknown option: #{option}"
    end
  end

  def show_options
    puts "URL: #{@url || 'not set'}"
    puts "Wordlist File: #{@wordlist_file}"
  end
end