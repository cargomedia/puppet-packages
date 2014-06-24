require 'ipaddress'
module Puppet::Parser::Functions
  newfunction(:get_ipaddress, :type => :rvalue) do |args|
    if args[0] and !args[0].empty?
      interface = args[0].to_s
      lookupvar('::ipaddress_' + interface)
    else
      ipaddr = ''
      lookupvar('::interfaces').split(',').each do |interface|
        next if interface == 'lo'
        ipaddr_fact = lookupvar('::ipaddress_' + interface)
        next if not IPAddress.valid_ipv4?(ipaddr_fact)
        ipaddr = IPAddress::IPv4.new(ipaddr_fact)
        break if ipaddr.private?
      end
      ipaddr.to_s
    end
  end
end
