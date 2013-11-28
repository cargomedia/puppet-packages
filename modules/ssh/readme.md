```puppet
node storage1 {
  ssh::auth::id {'root@storage1.cargomedia.ch':
    user => 'root',
  }
}

node backup1 {
  ssh::auth::grant {'root@storage1.cargomedia.ch for foo@backup1.cargomedia.ch':
    id => 'root@storage1.cargomedia.ch',
    user => 'foo',
  }
  ssh::auth::grant {'root@storage1.cargomedia.ch for root@backup1.cargomedia.ch':
    id => 'root@storage1.cargomedia.ch',
    user => 'root',
  }
}

node backup2 {
  ssh::auth::grant {'root@storage1.cargomedia.ch for bar@backup2.cargomedia.ch':
    id => 'root@storage1.cargomedia.ch',
    user => 'bar',
  }
}
```
