module Puppet::Parser::Functions
  newfunction(:apt_cache_age, :type => :rvalue) do |args|
    path = args[0] || '/var/lib/apt/periodic/update-success-stamp'

    if File.exist?(path)
      (Time.now - File.stat(path).mtime).to_i
    else
      999999999
    end
  end
end
