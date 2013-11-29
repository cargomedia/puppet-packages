Install private and public key for root@storage1:

```puppet
node storage1 {
  ssh::auth::id {'root@storage1.cargomedia.ch':
    user => 'root',
  }
}
```

Allow root@storage1 to login as foo or root to backup1:

```puppet
node backup1 {
  ssh::auth::grant {'foo@backup1.cargomedia.ch for root@storage1.cargomedia.ch':
    id => 'root@storage1.cargomedia.ch',
    user => 'foo',
  }
  ssh::auth::grant {'root@backup1.cargomedia.ch for root@storage1.cargomedia.ch':
    id => 'root@storage1.cargomedia.ch',
    user => 'root',
  }
}
```

Allow root@storage1 to login as bar to backup2:

```puppet
node backup2 {
  ssh::auth::grant {'bar@backup2.cargomedia.ch for root@storage1.cargomedia.ch':
    id => 'root@storage1.cargomedia.ch',
    user => 'bar',
  }
}
```
