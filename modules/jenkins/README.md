Jenkins
=======

Distributed builds (cluster)
----------------------------

Configure a *master* jenkins node:
```puppet
node master {
  class {'jenkins':
    hostname => 'example.com',
    cluster_id => 'my-cluster-1',
  }
}
```

Configure a *slave* jenkins node:
```puppet
node slave {
  class {'jenkins::slave':
    cluster_id => 'my-cluster-1',
  }
}
```

Make sure both classes share the same `cluster_id`.
An SSH key pair for the user `jenkins` will be installed for the *master* to log in to the *slave*.
The `jenkins::slave` will export a configuration resource that will be collected on the *master* making the slave known.
