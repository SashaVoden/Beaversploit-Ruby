require 'net/ssh'

class SSHConnect
  attr_accessor :options

  def initialize
    @options = {
      "host" => "127.0.0.1",
      "user" => "root",
      "password" => "toor"
    }
  end

  def set_option(option, value)
    if @options.key?(option.downcase)
      @options[option.downcase] = value
    else
      puts "[-] Unknown option: #{option}"
    end
  end

  def show_options
    puts "\n[SSHConnect Options]"
    @options.each { |key, value| puts "#{key.capitalize}: #{value}" }
    puts ""
  end

  def run
    puts "[*] Connecting to #{@options['host']}..."
    begin
      Net::SSH.start(@options["host"], @options["user"], password: @options["password"]) do |ssh|
        puts "[+] Connected"
        puts ssh.exec!("hostname")
      end
    rescue => e
      puts "[-] Error Connecting: #{e.message}"
    end
  end
end