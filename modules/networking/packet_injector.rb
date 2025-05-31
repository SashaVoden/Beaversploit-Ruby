require 'socket'

class PacketInjector
  def initialize
    @interface = nil
    @payload = nil
  end

  def detect_os
    case RUBY_PLATFORM
    when /linux/
      puts "[+] Running on Linux"
    else
      puts "[!] Unsupported OS: Windows detected"
      exit
    end
  end

  def check_root
    if Process.uid != 0
      puts "[!] Root required. run BeaverSploit as sudo"
      exit
    end
  end

  def set(option, value)
    case option.downcase
    when "interface"
      @interface = value
    when "payload"
      @payload = value
    else
      puts "[!] Unknown parameter: #{option}"
    end
  end

  def run
    detect_os
    check_root

    if @interface.nil? || @payload.nil?
      puts "[!] Interface and payload must be set!"
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
      puts "[!] Error: #{e.message}"
    end
  end
end