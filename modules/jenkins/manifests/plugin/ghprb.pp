class jenkins::plugin::ghprb(
  $accessToken,
  $adminList = []
) {

  require 'jenkins::plugin::git'
  require 'jenkins::plugin::github'
  require 'jenkins::plugin::github-api'

  file {'/var/lib/jenkins/org.jenkinsci.plugins.ghprb.GhprbTrigger.xml':
    ensure    => 'present',
    content   => template('jenkins/plugin/ghprb.xml'),
    owner     => 'jenkins',
    group     => 'nogroup',
    mode      => '0644',
  }
  ->

  jenkins::plugin {'ghprb':
    version => '1.9',
  }

}
