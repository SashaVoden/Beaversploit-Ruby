class ModulesInstaller
  def initialize(repo_url = nil, target_directory = "modules")
    @repo_url = repo_url || "https://github.com/YOUR_USERNAME/BeaverSploit-modules.git"
    @target_directory = target_directory
  end

  def run
    if Dir.exist?(@target_directory) && File.exist?(File.join(@target_directory, ".git"))
      puts "[*] Updating modules from #{@repo_url}..."
      system("cd #{@target_directory} && git pull")
    else
      puts "[*] Cloning modules from #{@repo_url}..."
      system("git clone #{@repo_url} #{@target_directory}")
    end
  end

  def set_option(option, value)
    case option.downcase
    when "repo_url"
      @repo_url = value
    when "target_directory"
      @target_directory = value
    else
      puts "[-] Unknown option: #{option}"
    end
  end

  def show_options
    puts "Repo URL: #{@repo_url}"
    puts "Target Directory: #{@target_directory}"
  end
end