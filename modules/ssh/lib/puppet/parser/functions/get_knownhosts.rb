module Puppet::Parser::Functions
  newfunction(:get_knownhosts, :type => :rvalue) do |args|
    aliases = []
    aliases.push lookupvar('hostname')
    lookupvar('interfaces').split(',').each do |interface|
      next if interface == 'lo'
      ipaddress = lookupvar('ipaddress_' + interface)
      aliases.push ipaddress if ipaddress
    end
    {'host' => lookupvar('fqdn'), 'aliases' => aliases}
  end
end
