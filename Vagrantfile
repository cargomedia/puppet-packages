require 'fileutils'
Vagrant.require_plugin 'vagrant-proxyconf'

Vagrant.configure("2") do |config|
  config.vm.box = "debian-6-amd64"
  config.vm.box_url = "http://s3.cargomedia.ch/vagrant-boxes/debian-6-amd64.box"
  config.vm.network :private_network, ip: '10.10.10.54'

  http_cache_dir = File.expand_path '.http-cache'
  FileUtils.mkdir_p http_cache_dir
  config.vm.synced_folder http_cache_dir, '/tmp/http-cache'
  config.proxy.https = 'http://localhost:8123/'
  config.proxy.http = 'http://localhost:8123/'
  config.proxy.no_proxy = "127.0.0.1,localhost,.nsa.gov"
  commands = [
      'no_proxy=.debian.org NO_PROXY=.debian.org apt-get -qy install polipo',
      'rm -rf /var/cache/polipo',
      'ln -s /tmp/http-cache /var/cache/polipo',
  ]
  config.vm.provision :shell, :inline => commands.join(' && ')

  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "spec"
    puppet.manifest_file = "provision.pp"
    puppet.module_path = "modules"
  end
end
