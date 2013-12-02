module Puppet::Parser::Functions
  newfunction(:extract_public_key, :type => :rvalue) do |args|
    key = args[0]
    match_data = /^([^\s]+)\s+([^\s]+)\s+([^\s]+)/.match(key)
    {'type' => match_data[1], 'sha' => match_data[2], 'comment' => match_data[3]}
  end
end
