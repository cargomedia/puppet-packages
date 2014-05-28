module Puppet::Parser::Functions
  newfunction(:get_knownhosts, :type => :rvalue) do |args|
    fqdn = args[0].to_s
    hostname = fqdn.split('.').shift
    aliases = []
    aliases.push hostname
    lookupvar('::interfaces').split(',').each do |interface|
      next if interface == 'lo'
      ipaddress = lookupvar('::ipaddress_' + interface)
      aliases.push ipaddress if ipaddress
    end
    aliases
  end
end
