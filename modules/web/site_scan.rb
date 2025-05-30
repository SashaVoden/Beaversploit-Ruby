require 'net/http'
require 'uri'

class SiteScan
  def initialize
    @url = nil
    @sql_enabled = false
    @xss_enabled = false
    @dictionary = nil
  end

  def run
    if @url.nil? || @url.strip.empty?
      puts "[-] URL is not set! Use 'set url <target>'"
      return
    end

    puts "[*] Starting site scan for #{@url}..."

    run_sql_scan if @sql_enabled
    run_xss_scan if @xss_enabled
    run_bruteforce if @dictionary
  end

  def run_sql_scan
    puts "[*] Running SQL Injection test..."
    injection = "' OR '1'='1"
    begin
      uri = URI(@url)
      new_query = (uri.query ? "#{uri.query}&" : "") + "test=" + URI.encode(injection)
      uri.query = new_query
      response = Net::HTTP.get_response(uri)
      puts "[*] SQL Injection test response code: #{response.code}"
      if response.code.to_i == 200
        puts "[+] Potential SQL Injection vulnerability detected at parameter 'test'."
      else
        puts "[-] No SQL Injection vulnerability detected for parameter 'test'."
      end
    rescue => e
      puts "[-] Error during SQL Injection test: #{e}"
    end
  end

  def run_xss_scan
    puts "[*] Running XSS test..."
    xss_payload = "<script>alert(1)</script>"
    begin
      uri = URI(@url)
      new_query = (uri.query ? "#{uri.query}&" : "") + "xss=" + URI.encode(xss_payload)
      uri.query = new_query
      response = Net::HTTP.get_response(uri)
      body = response.body
      if body && body.include?(xss_payload)
        puts "[+] Potential XSS vulnerability detected: payload reflected in response."
      else
        puts "[-] XSS payload not reflected in response."
      end
    rescue => e
      puts "[-] Error during XSS test: #{e}"
    end
  end

  def run_bruteforce
    puts "[*] Running directory brute force scan using dictionary: #{@dictionary}"
    unless File.exist?(@dictionary)
      puts "[-] Dictionary file not found: #{@dictionary}"
      return
    end
    begin
      uri_base = URI(@url)
    rescue => e
      puts "[-] Error parsing URL: #{e}"
      return
    end

    found = []
    File.foreach(@dictionary) do |line|
      word = line.strip
      next if word.empty?
      test_uri = uri_base.dup
      base_path = uri_base.path.empty? ? "/" : uri_base.path
      test_uri.path = File.join(base_path, word)
      begin
        response = Net::HTTP.get_response(test_uri)
        if response.code.to_i == 200
          puts "[+] Found directory: #{test_uri}"
          found << test_uri.to_s
        else
          puts "[-] Tested: #{test_uri} - Response code: #{response.code}"
        end
      rescue => e
        puts "[-] Error testing #{test_uri}: #{e}"
      end
      sleep 0.2
    end

    if found.any?
      puts "[*] Directory brute force scan completed. Found directories: #{found.size}"
    else
      puts "[*] Directory brute force scan completed. No directories found."
    end
  end

  def set_option(option, value)
    case option.downcase
    when "url"
      @url = value
    when "sql"
      @sql_enabled = (value.downcase == "true")
    when "xss"
      @xss_enabled = (value.downcase == "true")
    when "dictionary"
      @dictionary = value
    else
      puts "[-] Unknown option: #{option}"
    end
  end

  def show_options
    puts "URL: #{@url || 'not set'}"
    puts "SQL test enabled: #{@sql_enabled}"
    puts "XSS test enabled: #{@xss_enabled}"
    puts "Dictionary: #{@dictionary || 'not set'}"
  end
end