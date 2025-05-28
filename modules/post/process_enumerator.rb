require 'rbconfig'

class ProcessEnumerator
  def initialize
  end

  def run
    os = RbConfig::CONFIG['host_os']
    puts "[*] Enumerating running processes..."
    process_list = if os =~ /mswin|mingw|cygwin/
                     `tasklist`
                   else
                     `ps aux`
                   end
    puts process_list
  end

  def set_option(option, value)
    puts "No configurable options for ProcessEnumerator."
  end

  def show_options
    puts "No options to configure for ProcessEnumerator."
  end
end