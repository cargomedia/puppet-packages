require 'yaml'

module Puppet::Parser::Functions
  newfunction(:hash_to_yml, :type => :rvalue) do |args|
    args[0].to_yaml
  end
end
