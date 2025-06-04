require 'net/http'
require 'fileutils'

class FileHunter
  def initialize
    @options = { "URL" => "" }
  end

  def set_option(option, value)
    key = @options.keys.find { |k| k.downcase == option.downcase.strip }
    if key
      @options[key] = value
      puts "[*] Set #{key} to #{value}"
    else
      puts "[-] Option '#{option}' not found."
    end
  end

  def show_options
    puts "\n[FileHunter Options]"
    @options.each { |k, v| puts "#{k.ljust(12)}: #{v}" }
    puts ""
  end

  def run
    url = @options["URL"]
    if url.strip.empty?
      puts "[-] URL not set. Use 'set URL <value>' to set it."
      return
    end

    unless Dir.exist?("found")
      Dir.mkdir("found")
      puts "[+] Created 'found/' directory."
    end

    file_list = ["robots.txt", ".env", "config.php.bak"]
    puts "[+] Searching for sensitive files on #{url}..."
    
    file_list.each do |file|
      begin
        response = Net::HTTP.get_response(URI("#{url}/#{file}"))
        if response.code.to_i == 200
          file_path = "found/#{file}"
          File.open(file_path, "w") { |f| f.write(response.body) }
          puts "[*] Found #{file}, saved at #{file_path}"
        else
          puts "[-] Not found: #{file} (#{response.code})"
        end
      rescue => e
        puts "[-] Error accessing #{file}: #{e.message}"
      end
    end
  end
end