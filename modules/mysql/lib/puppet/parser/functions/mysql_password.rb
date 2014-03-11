require 'digest/sha1'

module Puppet::Parser::Functions
  newfunction(:mysql_password, :type => :rvalue, :doc => <<-EOS
    Returns the mysql password hash from the clear text password.
  EOS
  ) do |args|

    raise(Puppet::ParseError, "mysql_password(): Wrong number of arguments given (#{args.size} for 1)") if args.size != 1

    cleartext = args[0]
    hash = ''

    if cleartext.length > 0
      hash = '*' + Digest::SHA1.hexdigest(Digest::SHA1.digest(cleartext)).upcase
    end

    hash
  end
end
