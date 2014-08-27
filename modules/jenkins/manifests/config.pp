class jenkins::config(
  $numExecutors
) {

  require 'jenkins::package'
  include 'jenkins::service'

  file {'/var/lib/jenkins/config.d':
    ensure    => 'directory',
    owner     => 'jenkins',
    group     => 'nogroup',
    mode      => '0755',
    purge     => true,
  }

  file {'/var/lib/jenkins/config.d/_dummy.xml':
    ensure    => 'present',
    owner     => 'jenkins',
    group     => 'nogroup',
    mode      => '0644',
  }

  file {'/var/lib/jenkins/config.d-header.xml':
    ensure    => 'present',
    content   => template('jenkins/config.d-header.xml'),
    owner     => 'jenkins',
    group     => 'nogroup',
    mode      => '0644',
    notify    => Exec['/var/lib/jenkins/config.xml'],
  }

  file {'/var/lib/jenkins/config.d-footer.xml':
    ensure    => 'present',
    content   => template('jenkins/config.d-footer.xml'),
    owner     => 'jenkins',
    group     => 'nogroup',
    mode      => '0644',
    notify    => Exec['/var/lib/jenkins/config.xml'],
  }

  exec {'/var/lib/jenkins/config.xml':
    command     => '/bin/cat /var/lib/jenkins/config.d-header.xml /var/lib/jenkins/config.d/* /var/lib/jenkins/config.d-footer.xml > /var/lib/jenkins/config.xml',
    refreshonly => true,
    user        => 'jenkins',
    group       => 'nogroup',
    require     => [
      File['/var/lib/jenkins/config.d'],
      File['/var/lib/jenkins/config.d/_dummy.xml'],
      File['/var/lib/jenkins/config.d-header.xml'],
      File['/var/lib/jenkins/config.d-footer.xml']
    ],
    subscribe   => [
      File['/var/lib/jenkins/config.d-header.xml'],
      File['/var/lib/jenkins/config.d-footer.xml']
    ],
    notify      => Service['jenkins'],
  }

  file {'/var/lib/jenkins/jenkins.model.JenkinsLocationConfiguration.xml':
    ensure    => 'present',
    content   => template('jenkins/jenkins.model.JenkinsLocationConfiguration.xml'),
    owner     => 'jenkins',
    group     => 'nogroup',
    mode      => '0644',
    notify    => Service['jenkins'],
  }

  file {'/var/lib/jenkins/org.jenkinsci.main.modules.sshd.SSHD.xml':
    ensure    => 'present',
    content   => template('jenkins/org.jenkinsci.main.modules.sshd.SSHD.xml'),
    owner     => 'jenkins',
    group     => 'nogroup',
    mode      => '0644',
    notify    => Service['jenkins'],
  }

  file {'/var/lib/jenkins/hudson.tasks.Mailer.xml':
    ensure    => 'present',
    content   => template('jenkins/hudson.tasks.Mailer.xml'),
    owner     => 'jenkins',
    group     => 'nogroup',
    mode      => '0644',
    notify    => Service['jenkins'],
  }

}
