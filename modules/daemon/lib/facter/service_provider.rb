Facter.add('service_provider') do

  confine :kernel => :linux

  setcode do
    if File.exists?('/bin/systemctl')
      'systemd'
    elsif File.exists?('/sbin/upstart-local-bridge')
      'upstart'
    else
      'debian'
    end
  end
end
