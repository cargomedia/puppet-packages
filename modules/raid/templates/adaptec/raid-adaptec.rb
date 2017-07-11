#!/usr/bin/env ruby

command = ARGV[0] || 'usage'

def get_controller_id ()
  controllers = `/usr/sbin/arcconf GETVERSION`
  matches = /Controllers Found: (?<controller_id>\d+)/i.match(controllers)
  if matches.nil? or not matches.names.include?('controller_id') or matches['controller_id'] == '0'
    raise 'No controller found'
  end
  matches['controller_id']
end

def usage ()
  puts 'Usage: raid-adaptec [status|list_devices_with_cache]'
end

def status ()
  controller_id = get_controller_id
  logical_device_info = `/usr/sbin/arcconf getconfig #{controller_id} LD`
  matches = /Status of Logical Device\s+:\s(?<status>\S+)/i.match(logical_device_info)
  status = (not matches.nil? and matches.names.include?('status')) ? matches['status'] : 'Undefined'
  if status != 'Optimal'
    raise "Adaptech Logical Volume is in #{status} status"
  end
end

def list_devices_with_cache ()
  controller_id = get_controller_id
  physical_device_info = `/usr/sbin/arcconf getconfig #{controller_id} PD`
  devices = physical_device_info.scan(/(Device #\d.*?NCQ Status\s+:\s\S+)/im)
  devices.each do |device_info|
    device_info = device_info.to_s
    device_id = /Device #(?<device_id>\d)/i.match(device_info)['device_id']
    matches = /Write Cache\s+:\s(?<status>\S+)/i.match(device_info)
    status = (not matches.nil? and matches.names.include?('status')) ? matches['status'] : 'Undefined'
    if status == 'Enabled'
      puts "Write Cache enabled on device #{device_id}"
    end
  end
end

send(command)
