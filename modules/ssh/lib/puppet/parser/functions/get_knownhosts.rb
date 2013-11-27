module Puppet::Parser::Functions
  newfunction(:get_knownhosts, :type => :rvalue) do |args|
    aliases = []
    aliases.push lookupvar('hostname')
    lookupvar('interfaces').split(',').each do |interface|
      aliases.push lookupvar('ipaddress_' + interface) unless interface == 'lo'
    end
    {'host' => lookupvar('fqdn'), 'aliases' => aliases}
  end
end
