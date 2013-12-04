# SSH key management

## Defining an Identity and granting login access

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

## Custom Identity identifier
You can define a custom identifier for an `ssh::auth::id`.
This is useful if multiple machines and/or users should share a common identity (private key).

```puppet
node storage1 {
  ssh::auth::id {'root@storage1.cargomedia.ch':
    id => 'root@storage.cargomedia.ch',
    user => 'root',
  }
}

node storage2 {
  ssh::auth::id {'root@storage2.cargomedia.ch':
    id => 'root@storage.cargomedia.ch',
    user => 'root',
  }
}
```

Allow root on both storage1 and storage2 to login as foo to backup1:
```puppet
node backup1 {
  ssh::auth::grant {'foo@backup1.cargomedia.ch for root@storage.cargomedia.ch':
    id => 'root@storage.cargomedia.ch',
    user => 'foo',
  }
}
```
