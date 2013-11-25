class jenkins::plugin::git(
  $globalConfigName = 'example',
  $globalConfigEmail = 'example@example.com'
) {

  require 'jenkins::plugin::git-client'
  require 'jenkins::plugin::ssh-agent'

  file {'/var/lib/jenkins/hudson.plugins.git.GitSCM.xml':
    ensure    => 'present',
    content   => template('jenkins/plugin/git.xml'),
    owner     => 'jenkins',
    group     => 'nogroup',
    mode      => '0644',
  }
  ->

  jenkins::plugin {'git':
    version => '1.5.0',
  }

}
