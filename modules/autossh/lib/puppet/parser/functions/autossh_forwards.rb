module Puppet::Parser::Functions
  newfunction(:autossh_forwards, :type => :rvalue, :doc => <<-EOS
    Return ssh port forwarding arguments
  EOS
  ) do |args|
    forwards = args[0]
    forwards.map do |source, target|
      if source =~ /^\d+$/
        "-R #{target}:localhost:#{source}"
      else
        "-R #{target}:#{source}"
      end
    end * ' '
  end
end
