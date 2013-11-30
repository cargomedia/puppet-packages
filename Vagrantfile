require 'fileutils'
Vagrant.require_plugin 'vagrant-proxyconf'

Vagrant.configure("2") do |config|
  cacheDirOnHost = "#{Dir.pwd}/.http-cache"
  FileUtils.mkdir_p(cacheDirOnHost) unless File.directory?(cacheDirOnHost)
  config.vm.box = "debian-6-amd64"
  config.vm.box_url = "http://s3.cargomedia.ch/vagrant-boxes/debian-6-amd64.box"
  config.vm.network :private_network, ip: '10.10.20.2'
  config.vm.synced_folder cacheDirOnHost, '/var/cache/polipo', :nfs => true
  config.proxy.https = "http://localhost:8123/"
  config.proxy.http = "http://localhost:8123/"
  config.proxy.no_proxy = "127.0.0.1,localhost,.nsa.gov"
  commands = [
    'umount /var/cache/polipo;',
    'export no_proxy=.debian.org;',
    'export NO_PROXY=.debian.org;',
    'apt-get -yqq install polipo;',
    "mount 10.10.20.1:#{cacheDirOnHost} /var/cache/polipo;",
  ]
  config.vm.provision :shell, :inline => commands.join
end
