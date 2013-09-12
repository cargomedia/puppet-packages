# puppet-packages


## Install puppet
```bash
curl -Ls https://raw.github.com/cargomedia/puppet-packages/master/scripts/puppet-install.sh | bash
```

## Initial puppet run
### On agent
To make agent able to pull from master, master needs to accept agent's certificate.
Send certificate accept request from agent node by running:
```bash
puppet agent --test --server <puppet-master> --waitforcert 10 --tags puppet::agent
```


### On master
List certificates, pick correct and sign it:
```bash
puppet cert list
puppet cert sign <cert-name>
```

## Module development
It's recommended to test newly developed modules by applying manifests on debian vagrant box. In order to do so, please up a box using following Vagrantfile:
```ruby
Vagrant.configure("2") do |config|
    config.vm.box = "debian-6-amd64"
    config.vm.box_url = "http://s3.cargomedia.ch/vagrant-boxes/debian-6-amd64.box"
    config.vm.network :private_network, ip: "10.10.10.23"

    config.vm.synced_folder "<path-to-puppet-packages>", "/puppet/puppet-packages"
end
```
Once vagrant box is up, you can ssh into and run following command:
```
puppet apply --modulepath="/puppet/puppet-packages/modules" --verbose -e "include <developed-module>"
```
