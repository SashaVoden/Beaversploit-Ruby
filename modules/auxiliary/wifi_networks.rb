require 'rbconfig'

class WiFiNetworks
  def initialize
    @os = detect_os
  end

  def run
    puts "[*] Scanning available WiFi networks..."
    begin
      output = case @os
               when :windows
                 `netsh wlan show networks mode=Bssid`
               when :linux
                 `nmcli device wifi list`
               when :macos
                 airport_path = '/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'
                 `#{airport_path} -s`
               else
                 "Unsupported OS for WiFi scanning."
               end
      puts output
    rescue => e
      puts "[-] Error scanning WiFi networks: #{e.message}"
    end
  end

  def detect_os
    host_os = RbConfig::CONFIG['host_os']
    case host_os
    when /mswin|mingw|cygwin/
      :windows
    when /linux/
      :linux
    when /darwin/
      :macos
    else
      :unknown
    end
  end

  def set_option(option, value)
    puts "No configurable options for WiFiNetworks."
  end

  def show_options
    puts "No options available for WiFiNetworks."
  end
end