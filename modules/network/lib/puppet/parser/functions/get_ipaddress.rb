require 'ipaddress'
module Puppet::Parser::Functions
  newfunction(:get_ipaddress, :type => :rvalue) do |args|
    if args[0].to_s.length > 0
      interface = args[0].to_s
      lookupvar('::ipaddress_' + interface)
    else
      ipaddr = ''
      lookupvar('::interfaces').split(',').each do |interface|
        next if interface == 'lo'
        ipaddr = IPAddress::IPv4.new(lookupvar('::ipaddress_' + interface))
        if ipaddr.private?
          break
        end
      end
      ipaddr.to_s
    end
  end
end
