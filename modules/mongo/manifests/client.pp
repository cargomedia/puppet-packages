class mongo::client (
  $version = '2.6.0'
) {

  include 'mongo'

  package {'mongodb-org-shell':
    ensure  => $version,
    require => Class['mongo'],
  }

}
