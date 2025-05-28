require 'open3'

dependencies = {
  "Ruby" => "ruby -v",
  "Bundler" => "bundle -v",
}

dependencies.each do |name, command|
  output, status = Open3.capture2(command)
  if status.success?
    puts "#{name}: #{output.strip}"
  else
    puts "#{name}: Not installed"
  end
end