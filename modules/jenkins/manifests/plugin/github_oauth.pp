class jenkins::plugin::github_oauth(
  $organization_name_list,
  $admin_user_name_list,
  $client_id,
  $client_secret,
  $oauth_scopes = 'read:org,user:email',
) {

  require 'jenkins::plugin::matrix_auth'
  require 'jenkins::plugin::github_api'

  file { '/var/lib/jenkins/config.d/30-github-oauth.xml':
    ensure    => 'present',
    content   => template("${module_name}/plugin/github-oauth.xml"),
    owner     => 'jenkins',
    group     => 'nogroup',
    mode      => '0644',
    notify    => Exec['/var/lib/jenkins/config.xml'],
  }
  ->

  jenkins::plugin { 'github-oauth':
    version => '0.24',
  }

}
