node default {

  class {'jenkins':
    hostname => 'example.com'
  }

  class {'jenkins::plugin::github-oauth':
    organizationNameList => ['cargomedia'],
    adminUserNameList => ['njam'],
    clientId => 'xxx',
    clientSecret => 'yyy',
  }
}
