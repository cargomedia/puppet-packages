module Puppet::Parser::Functions
  newfunction(:autossh_options, :type => :rvalue, :doc => <<-EOS
    Return ssh option arguments
  EOS
  ) do |args|
    options = args[0]
    defaults = args[1] || {}
    options.merge(defaults).map do |key, value|
      "-o #{key}=#{value}"
    end * ' '
  end
end
