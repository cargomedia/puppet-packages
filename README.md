puppet-packages [![Build Status](http://ci.cargomedia.ch:8080/buildStatus/icon?job=cargomedia-puppet-packages)](http://ci.cargomedia.ch:8080/job/cargomedia-puppet-packages/)
===============
Reusable puppet modules for Debian Wheezy.

Install puppet
--------------
```sh
curl -Ls https://raw.github.com/cargomedia/puppet-packages/master/scripts/puppet-install.sh | bash
```

Initial puppet run
------------------
On agent:

To make agent able to pull from master, master needs to accept agent's certificate.
Send certificate accept request from agent node by running:
```sh
puppet agent --test --server <puppet-master> --waitforcert 10 --tags bootstrap
```


On master:
List certificates, pick correct and sign it:
```sh
puppet cert list
puppet cert sign <cert-name>
```

Module development
------------------
It's recommended to write specs for newly developed modules and test them by running appropriate rake task.

All specs should be placed in `modules/<module-name>/spec/<spec-name>/spec.rb`. This way they can be detected and form rake tasks.
Spec helper will also automatically apply all puppet manifests from the same dir (`*.pp`).

To test specific module run `rake spec:<module-name>`. To learn about other available tasks please run `rake --tasks`.
Our test tasks recognize following rake options:
- `debug=true` running puppet apply with `--debug` flag
- `keep_box=true` do not roll back the vm to a clean state
- `gui=true` show virtualbox GUI
- `os='Debian-8,Debian-9'` limit running specs to listed OS versions
- `retries=NUM` how many times to re-run a failed spec (default: 0)
