module Puppet::Parser::Functions
  newfunction(:htpasswd, :type => :rvalue) do |args|
    password = args[0]
    require 'digest/sha1'
    require 'base64'
    return '{SHA}' + Base64.encode64(Digest::SHA1.digest(password))
  end
end