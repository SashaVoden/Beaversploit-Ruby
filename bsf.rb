require_relative 'core'
require_relative 'cli'

core = BeaverSploit::Core.new
cli  = BeaverSploit::CLI.new(core)
cli.start