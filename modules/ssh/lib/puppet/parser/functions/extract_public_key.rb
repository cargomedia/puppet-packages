module Puppet::Parser::Functions
  newfunction(:extract_public_key, :type => :rvalue) do |args|
    key = args[0]
    match_data = /^(?:(ssh-[^\s]+)\s+)?([^\s]+)(?:\s+([^\s]+))?/.match(key)
    {
      'type' => match_data[1] || 'ssh-rsa',
      'sha' => match_data[2],
      'comment' => match_data[3] || '',
    }
  end
end
