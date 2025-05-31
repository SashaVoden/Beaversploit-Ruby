require 'socket'

class PacketInjector
  attr_accessor :interface, :payload

  def initialize
    @interface = "eth0"
    @payload = nil
  end

  def detect_os
    if RUBY_PLATFORM =~ /linux/
      puts "[+] Linux detected"
      true
    else
      puts "[-] This module is Linux-only. Detected OS: #{RUBY_PLATFORM}"
      false
    end
  end

  def check_root
    if Process.uid != 0
      puts "[-] Root required. Run as sudo"
      false
    else
      true
    end
  end

  def set(option, value)
    case option.downcase
    when "interface"
      @interface = value
    when "payload"
      @payload = value
    else
      puts "[-] Unknown option: #{option}"
    end
  end

  def show_options
    puts "[+] Interface: #{@interface}"
    puts "[+] Payload: #{@payload || 'Not set'}"
  end

  def run
    return unless detect_os && check_root

    if @payload.nil?
      puts "[-] Payload must be set before running."
      return
    end

    puts "[+] Starting packet injection on #{@interface}..."

    begin
      raw_socket = Socket.new(Socket::AF_PACKET, Socket::SOCK_RAW)
      raw_socket.bind(@interface)

      100.times do
        raw_socket.send(@payload, 0)
      end

      puts "[+] Packets sent successfully!"
    rescue => e
      puts "[-] Error: #{e.message}"
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  pi = PacketInjector.new
end