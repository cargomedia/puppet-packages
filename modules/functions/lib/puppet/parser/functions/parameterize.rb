module Puppet::Parser::Functions
	newfunction(:parameterize, :type => :rvalue) do |args|
		if args[1] != ''
			"--" + args[0] + "=" + args[1]
		else
			''
		end
	end
end
