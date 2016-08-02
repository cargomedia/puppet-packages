class jenkins::plugin::git(
  $global_config_name = 'example',
  $global_config_email = 'example@example.com'
) {

  require 'jenkins::plugin::git_client'
  require 'jenkins::plugin::ssh_agent'

  file { '/var/lib/jenkins/hudson.plugins.git.GitSCM.xml':
    ensure    => 'present',
    content   => template("${module_name}/plugin/git.xml"),
    owner     => 'jenkins',
    group     => 'nogroup',
    mode      => '0644',
  }
  ->

  jenkins::plugin { 'git':
    version => '2.4.4',
  }

}
