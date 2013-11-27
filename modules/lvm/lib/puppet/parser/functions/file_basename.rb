module Puppet::Parser::Functions
  newfunction(:file_basename, :type => :rvalue, :doc => <<-EOS
    Returns the file basename from full path.
  EOS
  ) do |args|
    File.basename args[0]
  end
end
