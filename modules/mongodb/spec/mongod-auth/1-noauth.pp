node default {

  mongodb::core::mongod { 'server':
    port => 27017,
    auth => false,
  }
  ->

  mongodb_user { 'myUserAdmin':
    database => 'admin',
    password => 'abc123',
    roles    => [ { 'role' => 'userAdminAnyDatabase', 'db' => 'admin' } ],
  }
  ->

  mongodb_user { 'siteRootAdmin':
    database          => 'admin',
    password          => 'abc123',
    roles             => [ { 'role' => 'root', 'db' => 'admin' } ],
    mongorc_autologin => true
  }
}
