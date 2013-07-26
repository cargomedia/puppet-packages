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
puppet agent --test --server <puppet-master> --waitforcert 10
```


### On master
List certificates, pick correct and sign it:
```bash
puppet cert list
puppet cert sign <cert-name>
```
