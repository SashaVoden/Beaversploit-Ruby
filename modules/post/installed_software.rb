require 'rbconfig'
require 'fileutils'

class InstalledSoftware
  def initialize
  end

  def run
    os = RbConfig::CONFIG['host_os']
    puts "[*] Enumerating installed software..."
    if os =~ /mswin|mingw|cygwin/
      software = `wmic product get name,version`
    else
      if File.exist?('/usr/bin/dpkg')
        software = `dpkg -l`
      elsif File.exist?('/usr/bin/rpm')
        software = `rpm -qa`
      else
        software = "No supported package manager found."
      end
    end
    puts software
  end

  def set_option(option, value)
    puts "No configurable options for InstalledSoftware."
  end

  def show_options
    puts "No options to configure for InstalledSoftware."
  end
end