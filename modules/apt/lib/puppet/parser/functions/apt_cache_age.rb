module Puppet::Parser::Functions
  newfunction(:apt_cache_age, :type => :rvalue) do |args|
    path = args[0] || '/var/cache/apt'

    (Time.now - File.stat(path).mtime).to_i
  end
end
