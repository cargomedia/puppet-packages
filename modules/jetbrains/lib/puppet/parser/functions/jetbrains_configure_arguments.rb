module Puppet::Parser::Functions
  newfunction(:jetbrains_configure_arguments, :type => :rvalue, :doc => <<-EOS
    Prepare jetbrains configure command arguments
  EOS
  ) do |args|
    config = args[0]
    config.scan(/(?<key>.+)=(?<value>.+)/).map do |key, value|
      "--#{key}=#{value}"
    end * ' '
  end
end
