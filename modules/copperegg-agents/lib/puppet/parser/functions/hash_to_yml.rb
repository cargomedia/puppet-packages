require 'yaml'

module Puppet::Parser::Functions
  newfunction(:hash_to_yml, :type => :rvalue) do |args|
    hash = args[0]
    hash.to_yaml
  end
end
