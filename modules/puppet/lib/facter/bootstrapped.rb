Facter.add("bootstrapped") do
	setcode do
		File.exist? "/etc/bootstrapped"
	end
end
