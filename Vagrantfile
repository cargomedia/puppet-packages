Vagrant.configure("2") do |config|
	config.vm.box = "debian-6-amd64"
	config.vm.box_url = "http://s3.cargomedia.ch/vagrant-boxes/debian-6-amd64.box"

	cmd = "sudo apt-get install -qy libaugeas-ruby"
	config.vm.provision :shell, :inline => cmd
end
