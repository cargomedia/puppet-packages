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
bash <(curl -Ls https://raw.github.com/cargomedia/puppet-packages/master/scripts/puppet-set-server.sh) <git-url>
```

There needs to be `modules` directory in root of git repository.


