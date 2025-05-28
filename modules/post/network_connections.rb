require 'rbconfig'

class NetworkConnections
  def initialize
  end

  def run
    os = RbConfig::CONFIG['host_os']
    puts "[*] Enumerating active network connections..."
    connections = if os =~ /mswin|mingw|cygwin/
                    `netstat -ano`
                  else
                    `netstat -tunp 2>/dev/null`
                  end
    puts connections
  end

  def set_option(option, value)
    puts "No configurable options for NetworkConnections."
  end

  def show_options
    puts "No options to configure for NetworkConnections."
  end
end