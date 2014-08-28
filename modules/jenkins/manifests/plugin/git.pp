class jenkins::plugin::git(
  $globalConfigName = 'example',
  $globalConfigEmail = 'example@example.com'
) {

  require 'jenkins::plugin::git_client'
  require 'jenkins::plugin::ssh_agent'

  file {'/var/lib/jenkins/hudson.plugins.git.GitSCM.xml':
    ensure    => 'present',
    content   => template("${module_name}/plugin/git.xml"),
    owner     => 'jenkins',
    group     => 'nogroup',
    mode      => '0644',
  }
  ->

  jenkins::plugin {'git':
    version => '1.5.0',
  }

}
