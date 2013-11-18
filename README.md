# puppet-packages

[![Build Status](https://travis-ci.org/cargomedia/puppet-packages.png?branch=master)](https://travis-ci.org/cargomedia/puppet-packages)

## Install puppet
```bash
curl -Ls https://raw.github.com/cargomedia/puppet-packages/master/scripts/puppet-install.sh | bash
```

## Initial puppet run
### On agent
To make agent able to pull from master, master needs to accept agent's certificate.
Send certificate accept request from agent node by running:
```bash
puppet agent --test --server <puppet-master> --waitforcert 10 --tags bootstrap
```


### On master
List certificates, pick correct and sign it:
```bash
puppet cert list
puppet cert sign <cert-name>
```

## Module development
It's recommended to write specs for newly developed modules and test them by running appropriate rake task.

All specs should be placed in `modules/<module-name>/spec/<spec-name>/spec.rb`. This way they can be detected and form rake tasks.
Spec helper will also automatically apply all puppet manifests from the same dir (`*.pp`).

To test specific module run `rake test:<module-name>`. To learn about other available tasks please run `rake --tasks`.
Our test tasks recognize following rake options:
- `verbose=true` verbose output
- `debug=true` running puppet apply with `--debug` flag