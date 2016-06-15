require 'ipaddress'
module Puppet::Parser::Functions
  newfunction(:get_ipaddress, :type => :rvalue) do |args|

    networking_fact = lookupvar('::networking')
    interfaces = networking_fact['interfaces']

    exclude_interfaces = [/^lo$/, /^vboxnet[\d]{1,2}$/]

    if args[0] and !args[0].empty?
      interfaces[args[0].to_s]['ip']
    else
      ipaddr = ''
      interfaces.each do |interface_key, interface_value|
        next if interface_key =~ Regexp.union(exclude_interfaces)
        ipaddr_fact = interface_value['ip']
        next if not IPAddress.valid_ipv4?(ipaddr_fact)
        ipaddr = IPAddress::IPv4.new(ipaddr_fact)
        break if ipaddr.private?
      end
      ipaddr.to_s
    end
  end
end
