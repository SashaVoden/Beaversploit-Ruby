require_relative 'core'

module BeaverSploit
  class CLI
    def initialize(core)
      @core = core
    end

    def start
      loop do
        puts "This is test version of beaversploit on ruby"
        print "bsf > "
        input = gets.strip
        case input.downcase
        when "exit", "quit"
          puts "[*] Exiting..."
          break
        when "list"
          @core.list_modules
        when /^use (.+)$/
          module_key = $1.strip.downcase
          mod = @core.get_module(module_key)
          if mod
            module_session(mod)
          else
            puts "[-] Module '#{module_key}' not found."
          end
        else
          puts "[-] Unknown command."
        end
      end
    end

    def module_session(mod)
      puts "[*] Now working with module: #{mod.class.name}"
      loop do
        print "bsf (#{mod.class.name}) > "
        input = gets.strip
        case input.downcase
        when "back", "exit"
          puts "[*] Exiting module context..."
          break
        when /^set (\S+) (.+)$/
          option = $1.strip
          value = $2.strip
          if mod.respond_to?(:set_option)
            mod.set_option(option, value)
          else
            puts "[-] Options not supported for this module."
          end
        when "show options"
          if mod.respond_to?(:show_options)
            mod.show_options
          else
            puts "[-] Options not supported for this module."
          end
        when "run"
          mod.run
        else
          puts "[-] Unknown command in module context. Commands: set, show options, run, back."
        end
      end
    end
  end
end