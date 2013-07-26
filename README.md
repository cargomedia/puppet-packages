# puppet-packages


## Install puppet
```bash
curl -Ls https://raw.github.com/cargomedia/puppet-packages/master/scripts/puppet-install.sh | bash
```

There needs to be `modules` directory in root of git repository.

## Connecting agent with master, initial puppet run
To make agent able to pull from master, master needs to accept agent's certificate.
Send certificate accept request from agent node by running:
```bash
puppet agent --test --server <puppet-master> --waitforcert 10
```


List certificates on master, pick correct and sign it:
```bash
puppet cert list
puppet cert sign <cert-name>
```
