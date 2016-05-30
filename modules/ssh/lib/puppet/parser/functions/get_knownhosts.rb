module Puppet::Parser::Functions
  newfunction(:get_knownhosts, :type => :rvalue) do |args|
    fqdn = args[0].to_s
    hostname = fqdn.split('.').shift
    aliases = []
    aliases.push hostname

    networking_fact = lookupvar('networking')
    interfaces = networking_fact['interfaces']

    exclude_interfaces = [/^lo$/, /^vboxnet[\d]{1,2}$/]

    interfaces.each do |interface|
      next if interface[0] =~ Regexp.union(exclude_interfaces)
      aliases.push interface[1]['ip'] if interface[1]['ip']
    end
    aliases
  end
end
