node default {

  $root_username = 'siteRootAdmin'
  $root_password = 'abc123'
  $root_dbname = 'admin'

  mongodb::core::mongod { 'server':
    port => 27017,
    auth => false,
  }
  ->

  mongodb_user { $root_username:
    database => $root_dbname,
    password => $root_password,
    roles    => [ { 'role' => 'root', 'db' => $root_dbname } ]
  }
  ->

  mongodb::mongorc::autologin { 'autologin-root':
    username => $root_username,
    password => $root_password,
    database => $root_dbname,
  }
}
