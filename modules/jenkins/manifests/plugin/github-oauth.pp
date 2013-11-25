class jenkins::plugin::github-oauth(
  $organizationNameList,
  $adminUserNameList,
  $clientId,
  $clientSecret
) {

  require 'jenkins::plugin::github-api'

  jenkins::plugin {'github-oauth':
    version => '0.14',
  }

  file {'/var/lib/jenkins/config.d/github-oauth.xml':
    ensure    => 'present',
    content   => template('jenkins/plugin/github-oauth.xml'),
    owner     => 'jenkins',
    group     => 'nogroup',
    mode      => '0644',
    notify    => Exec['/var/lib/jenkins/config.xml'],
  }

}
