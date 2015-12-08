Facter.add('init_system') do

  confine :kernel => :linux

  setcode do
    if File.exists?('/bin/systemctl')
      'systemd'
    elsif File.exists?('/sbin/upstart-local-bridge')
      'upstart'
    else
      'sysvinit'
    end
  end
end
