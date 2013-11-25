class jenkins(
  $hostname,
  $emailAdmin = 'root@localhost'
) {

  include 'jenkins::service'

  apt::source {'jenkins':
    entries => [
      'deb http://pkg.jenkins-ci.org/debian binary/',
    ],
    keys => {
      'jenkins' => {
        key     => 'D50582E6',
        key_url => 'http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key',
      }
    }
  }
  ->

  package {'jenkins':
    ensure => present,
  }
  ->

  file {'/var/lib/jenkins/plugins':
    ensure => 'directory',
    owner => 'jenkins',
    group => 'nogroup',
    mode => '0755',
  }
  ->

  file {'/var/lib/jenkins/jenkins.model.JenkinsLocationConfiguration.xml':
    ensure => 'present',
    content => template('jenkins/jenkins.model.JenkinsLocationConfiguration.xml'),
    owner => 'jenkins',
    group => 'nogroup',
    mode => '0644',
  }


}
