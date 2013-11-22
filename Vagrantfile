Vagrant.configure("2") do |config|
  config.vm.box = "debian-6-amd64"
  config.vm.box_url = "http://s3.cargomedia.ch/vagrant-boxes/debian-6-amd64.box"

  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "spec"
    puppet.manifest_file = "provision.pp"
    puppet.module_path = "modules"
  end
end
