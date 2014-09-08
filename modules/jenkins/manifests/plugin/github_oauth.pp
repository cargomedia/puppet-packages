class jenkins::plugin::github_oauth(
  $organizationNameList,
  $adminUserNameList,
  $clientId,
  $clientSecret
) {

  require 'jenkins::plugin::github_api'

  file {'/var/lib/jenkins/config.d/github-oauth.xml':
    ensure    => 'present',
    content   => template("${module_name}/plugin/github-oauth.xml"),
    owner     => 'jenkins',
    group     => 'nogroup',
    mode      => '0644',
    notify    => Exec['/var/lib/jenkins/config.xml'],
  }
  ->

  jenkins::plugin {'github-oauth':
    version => '0.14',
  }

}
