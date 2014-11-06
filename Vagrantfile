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

  # This is a an additional disk needed to test module lvm
  # It will show up as /dev/sdb in the guest OS
  config.vm.provider :virtualbox do |vb|
    hdd_path = File.expand_path File.dirname(__FILE__) + "/.vagrant/machines/wheezy/virtualbox/hard-disks/additional_disk.vdi"
    if !File.exists? hdd_path
      vb.customize ['createhd', '--filename', hdd_path, '--size', 500]
    end
    vb.customize ['storageattach', :id, '--storagectl', 'IDE Controller', '--port', 0, '--type', 'hdd', '--device', 1, '--medium', hdd_path]
   end

  config.vm.provision 'puppet' do |puppet|
    puppet.manifests_path = 'spec'
    puppet.manifest_file = 'provision.pp'
    puppet.module_path = 'modules'
  end

  config.vm.define 'wheezy', primary: true do |wheezy|
    wheezy.vm.box = 'cargomedia/debian-7-amd64-default'
    # Additional network card to test module network (resource type network::interface)
    wheezy.vm.network :private_network, ip: '10.10.20.2', auto_config: false
  end
end
