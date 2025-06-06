require 'open-uri'

REPO_URL = "https://raw.githubusercontent.com/SashaVoden/Beaversploit-Ruby/master/modules/"
local_modules = File.readlines("spec/bsf_modules.txt").map(&:strip)

local_modules.each do |mod|
  url = "#{REPO_URL}#{mod}"
  system("wget -O modules/#{mod} #{url}")
  puts "#{mod} updated"
end