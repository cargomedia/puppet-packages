# puppet-packages


## Install puppet
```bash
bash <(curl -Ls https://raw.github.com/cargomedia/puppet-packages/master/scripts/puppet-install.sh)
```

### Set master server
```bash
bash <(curl -Ls https://raw.github.com/cargomedia/puppet-packages/master/scripts/puppet-set-server.sh) <server-hostname>
```

### Add modules from git repository
```bash
bash <(curl -Ls https://raw.github.com/cargomedia/puppet-packages/master/scripts/puppet-add-modules-git.sh) <git-url>
```

There needs to be `modules` directory in root of git repository.

## Connecting agent with master
To make agent able to pull from master, master needs to accept agent's certificate.
Send certificate accept request from agent node by running:
```bash
puppet agent --test
```


On master list certificates, then pick correct one and sign it:
```bash
puppet cert list
puppet cert sign <cert-name>
```
