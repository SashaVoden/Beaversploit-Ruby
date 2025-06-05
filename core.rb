module BeaverSploit
  class Core
    attr_reader :plugins, :modules

    def initialize
      @plugins = {}
      @modules = {}
      load_plugins   # Загружаем плагины первыми
      load_modules   # Затем модули
    end

    def instantiate_file(file)
      before = Module.constants.dup
      require file
      after = Module.constants
      new_consts = after - before
      new_instance = nil
      new_consts.each do |const|
        begin
          candidate = Module.const_get(const)
          if candidate.is_a?(Class) && candidate.instance_methods.include?(:run)
            new_instance = candidate.new
            break
          end
        rescue
          next
        end
      end
      new_instance
    end

    def load_plugins
      base = File.join(__dir__, 'plugins')
      Dir.glob(File.join(base, '**', '*.rb')).each do |file|
        relative_key = file.sub("#{__dir__}/", "").gsub("\\", "/").downcase
        plugin_instance = instantiate_file(file)
        if plugin_instance
          @plugins[relative_key] = plugin_instance
          puts "[+] Loaded plugin: #{relative_key}"
        else
          puts "[-] Failed to load plugin: #{relative_key}"
        end
      end
    end

    def load_modules
      base = File.join(__dir__, 'modules')
      Dir.glob(File.join(base, '**', '*.rb')).each do |file|
        relative_key = file.sub("#{__dir__}/", "").gsub("\\", "/").downcase
        module_instance = instantiate_file(file)
        if module_instance
          @modules[relative_key] = module_instance
          puts "[*] Loaded module: #{relative_key}"
        else
          puts "[!] Failed to load module: #{relative_key}"
        end
      end
    end

    def list_plugins
      puts "\n*** Available Plugins ***"
      @plugins.keys.each { |key| puts " - #{key}" }
      puts "*************************"
    end

    def list_modules
      puts "\n*** Available Modules ***"
      @modules.keys.each { |key| puts " - #{key}" }
      puts "*************************"
    end

    def use_plugin(plugin_key)
      plugin = @plugins[plugin_key.downcase]
      if plugin
        puts "[+] Using plugin: #{plugin_key}"
        plugin.run
      else
        puts "[-] Plugin '#{plugin_key}' not found."
      end
    end

    def use_module(module_key)
      mod = @modules[module_key.downcase]
      if mod
        puts "[+] Using module: #{module_key}"
        mod.run
      else
        puts "[-] Module '#{module_key}' not found."
      end
    end
  end
end