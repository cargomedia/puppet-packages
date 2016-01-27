node default {

  mongodb::core::mongod { 'server':
    port => 27017,
    auth => true,
  }
  ->

  file { '/root/.mongorc.js':
    ensure  => file,
    content => 'login_db = db.getSiblingDB("admin"); login_db.auth("siteRootAdmin", "abc123");',
    mode    => '0755',
    group   => '0',
    owner   => '0',
  }
}
