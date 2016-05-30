module Puppet::Parser::Functions
  newfunction(:get_knownhosts, :type => :rvalue) do |args|
    fqdn = args[0].to_s
    hostname = fqdn.split('.').shift
    aliases = []
    aliases.push hostname

    networking_fact = lookupvar('::networking')
    interfaces = networking_fact['interfaces']

    exclude_interfaces = [/^lo$/, /^vboxnet[\d]{1,2}$/]

    interfaces.each do |interface_key, interface_value|
      next if interface_key =~ Regexp.union(exclude_interfaces)
      aliases.push interface_value['ip'] if interface_value['ip']
    end
    aliases
  end
end
