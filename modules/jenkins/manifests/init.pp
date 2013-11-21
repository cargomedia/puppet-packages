class jenkins {

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
}
