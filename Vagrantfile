Vagrant.configure('2') do |config|
  if Vagrant.has_plugin?('vagrant-proxyconf')
    config.vm.synced_folder '.proxy-cache', '/tmp/proxy-cache', :owner => 'proxy', :create => true
    if ['true', '1'].include?(ENV['DISABLE_PROXY'])
      config.proxy.https = false
      config.proxy.http = false
    else
      config.proxy.https = 'http://localhost:8123/'
      config.proxy.http = 'http://localhost:8123/'
      config.proxy.no_proxy = '127.0.0.1,localhost'
    end
  else
    warn("Installing the vagrant plugin 'vagrant-proxyconf' is highly recommended for dramatic performance gains. \nRun\n \`vagrant plugin install vagrant-proxyconf\` to install it")
  end
  config.vm.provision 'shell', path: 'scripts/puppet-install.sh'

  config.vm.provision 'puppet' do |puppet|
    puppet.environment_path = 'spec/puppet/environments'
    puppet.environment = 'default'
    puppet.module_path = 'modules'
  end

  config.vm.provider 'virtualbox' do |v|
    v.gui = (ENV['gui'] == 'true')
    # Soundcard to test audio-related modules
    v.customize ['modifyvm', :id, '--audio', 'null', '--audiocontroller', 'hda']
    # More performant NIC Adapter driver
    v.customize ['modifyvm', :id, '--nictype1', 'virtio']
  end

  config.vm.define 'Debian-8' do |jessie|
    jessie.vm.box = 'cargomedia/debian-8-amd64-plain'
    jessie.vm.network :forwarded_port, guest: 22, host: 22202, id: 'ssh'
    # Additional network card to test module network (resource type network::interface)
    jessie.vm.network :private_network, ip: '10.10.20.4', auto_config: false
  end
end
