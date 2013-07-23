module Puppet::Parser::Functions
	newfunction(:exec, :type => :rvalue) do |args|
		system(args[0] + ' 1>/dev/null 2>/dev/null')
	end
end
