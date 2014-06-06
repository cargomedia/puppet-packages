Vagrant.configure('2') do |config|

  config.vm.synced_folder '.proxy-cache', '/tmp/proxy-cache', :owner => 'proxy', :create => true
  if ['true', '1'].include?(ENV['DISABLE_PROXY'])
    config.proxy.https = false
    config.proxy.http = false
  else
    config.proxy.https = 'http://localhost:8123/'
    config.proxy.http = 'http://localhost:8123/'
    config.proxy.no_proxy = '127.0.0.1,localhost'
  end

  config.vm.provider :virtualbox do |vb|
    hdd_dir = ".vagrant/machines/wheezy/virtualbox/hard-disks"
    if !File.exists? hdd_dir
      vb.customize ['storagectl', :id, '--name', 'SATA Controller', '--add', 'sata', '--controller', 'IntelAHCI']
    end
    hdd_path = File.join(hdd_dir, "additional_disk.vdi")
    if !File.exists? hdd_path
      vb.customize ['createhd', '--filename', hdd_path, '--size', 500]
    end
    vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 1, '--type', 'hdd', '--medium', hdd_path]
   end

  config.vm.provision 'puppet' do |puppet|
    puppet.manifests_path = 'spec'
    puppet.manifest_file = 'provision.pp'
    puppet.module_path = 'modules'
  end

  config.vm.define 'wheezy', primary: true do |wheezy|
    wheezy.vm.box = 'cargomedia/debian-7-amd64-default'
  end
end
