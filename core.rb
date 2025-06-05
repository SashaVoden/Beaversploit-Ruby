module BeaverSploit
  class Core
    attr_reader :modules, :plugins

    def initialize
      @modules = {}
      @plugins = []
      load_modules
      load_plugins
    end

    def instantiate_module_from_file(file)
      before = Module.constants.dup
      require file
      after = Module.constants
      new_consts = after - before
      new_instance = nil
      new_consts.each do |const|
        begin
          candidate = Module.const_get(const)
          if candidate.is_a?(Class) &&
             candidate.instance_methods.include?(:run) &&
             candidate.instance_methods.include?(:set_option) &&
             candidate.instance_methods.include?(:show_options)
            new_instance = candidate.new
            break
          end
        rescue
          next
        end
      end
      new_instance
    end

    def load_modules
      base = File.join(__dir__, 'modules')
      Dir.glob(File.join(base, '**', '*.rb')).each do |file|
        relative_key = file.sub("#{__dir__}/", "").gsub("\\", "/").downcase
        module_instance = instantiate_module_from_file(file)
        if module_instance
          @modules[relative_key] = module_instance
          puts "[*] Loaded module: #{relative_key}"
        else
          puts "[!] Failed to instantiate module: #{relative_key}"
        end
      end
    end

    def load_plugins
      base = File.join(__dir__, 'plugins')
      Dir.glob(File.join(base, '**', '*.rb')).each do |file|
        begin
          puts "[+] Executing plugin: #{file}"
          require file
          @plugins << file
        rescue => e
          puts "[-] Failed to execute plugin: #{file} (#{e.message})"
        end
      end
    end

    def list_modules
      puts "\n*** Available Modules ***"
      @modules.keys.each { |key| puts " - #{key}" }
      puts "*************************"
    end

    def get_module(key)
      key = key.downcase
      @modules[key]
    end
  end
end