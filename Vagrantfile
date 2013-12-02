Vagrant.require_plugin 'vagrant-proxyconf'

Vagrant.configure("2") do |config|
  config.vm.box = "debian-6-amd64"
  config.vm.box_url = "http://s3.cargomedia.ch/vagrant-boxes/debian-6-amd64.box"

  config.vm.synced_folder '.proxy-cache', '/tmp/proxy-cache', :owner => 'proxy', :create => true
  if ['true', '1'].include?(ENV['DISABLE_PROXY'])
    config.proxy.https = false
    config.proxy.http = false
  else
    config.proxy.https = 'http://localhost:8123/'
    config.proxy.http = 'http://localhost:8123/'
    config.proxy.no_proxy = "127.0.0.1,localhost"
  end

  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "spec"
    puppet.manifest_file = "provision.pp"
    puppet.module_path = "modules"
  end
end
