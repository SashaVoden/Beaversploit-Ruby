require 'rbconfig'

class SystemInfo
  def initialize
  end

  def run
    puts "[*] Gathering system information..."
    hostname = `hostname`.strip rescue "Unknown"
    user = ENV['USER'] || ENV['USERNAME'] || "Unknown"
    os = RbConfig::CONFIG['host_os']
    ruby_version = RUBY_VERSION

    ip_info = if os =~ /mswin|mingw|cygwin/
                `ipconfig`
              else
                `ifconfig`
              end

    puts "Hostname: #{hostname}"
    puts "Current User: #{user}"
    puts "Operating System: #{os}"
    puts "Ruby Version: #{ruby_version}"
    puts "\nNetwork Information:\n#{ip_info}"
  end

  def set_option(option, value)
    puts "No configurable options for SystemInfo."
  end

  def show_options
    puts "No options to configure for SystemInfo."
  end
end