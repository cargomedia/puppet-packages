node default {

  class {'jenkins':
    hostname => 'example.com'
  }

  class {'jenkins::plugin::github_oauth':
    organizationNameList => ['cargomedia'],
    adminUserNameList => ['njam'],
    clientId => 'xxx',
    clientSecret => 'yyy',
  }
}
