module Puppet::Parser::Functions
  newfunction(:apt_cache_age, :type => :rvalue) do |args|
    path = args[0] || '/var/lib/apt/periodic/update-success-stamp'

    File.exist?(path) ? (Time.now - File.stat(path).mtime).to_i : 0
  end
end
