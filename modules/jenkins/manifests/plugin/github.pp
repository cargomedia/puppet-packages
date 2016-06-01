class jenkins::plugin::github(
  $oauth_access_token = undef,
  $username = undef,
  $password = undef,
  $api_url = undef
) {

  require 'jenkins::plugin::git'
  require 'jenkins::plugin::github_api'

  file { '/var/lib/jenkins/com.cloudbees.jenkins.GitHubPushTrigger.xml':
    ensure    => 'present',
    content   => template("${module_name}/plugin/github.xml"),
    owner     => 'jenkins',
    group     => 'nogroup',
    mode      => '0644',
  }
  ->

  jenkins::plugin { 'github':
    version => '1.18.2',
  }

}
