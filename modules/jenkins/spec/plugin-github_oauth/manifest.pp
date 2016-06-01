node default {

  class { 'jenkins':
    hostname => 'example.com'
  }

  class { 'jenkins::plugin::github_oauth':
    organization_name_list => ['cargomedia'],
    admin_user_name_list   => ['njam'],
    client_id              => 'xxx',
    client_secret          => 'yyy',
  }

}
