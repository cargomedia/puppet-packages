class jenkins::config::main(
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
    recurse   => true,
  }

  file {'/var/lib/jenkins/config.d/dummy.xml':
    ensure    => 'present',
    owner     => 'jenkins',
    group     => 'nogroup',
    mode      => '0644',
  }

  file {'/var/lib/jenkins/config.d/_header.xml':
    ensure    => 'present',
    content   => template("${module_name}/config/main/_header.xml"),
    owner     => 'jenkins',
    group     => 'nogroup',
    mode      => '0644',
    notify    => Exec['/var/lib/jenkins/config.xml'],
  }

  file {'/var/lib/jenkins/config.d/_footer.xml':
    ensure    => 'present',
    content   => template("${module_name}/config/main/_footer.xml"),
    owner     => 'jenkins',
    group     => 'nogroup',
    mode      => '0644',
    notify    => Exec['/var/lib/jenkins/config.xml'],
  }

  exec {'/var/lib/jenkins/config.xml':
    command     => '/bin/cat /var/lib/jenkins/config.d/_header.xml /var/lib/jenkins/config.d/[!_]* /var/lib/jenkins/config.d/_footer.xml > /var/lib/jenkins/config.xml',
    provider    => 'shell',
    refreshonly => true,
    user        => 'jenkins',
    group       => 'nogroup',
    require     => [
      File['/var/lib/jenkins/config.d'],
      File['/var/lib/jenkins/config.d/_header.xml'],
      File['/var/lib/jenkins/config.d/_footer.xml'],
      File['/var/lib/jenkins/config.d/dummy.xml']
    ],
    subscribe   => [
      File['/var/lib/jenkins/config.d/_header.xml'],
      File['/var/lib/jenkins/config.d/_footer.xml']
    ],
    notify      => Service['jenkins'],
  }

  file {'/var/lib/jenkins/jenkins.model.JenkinsLocationConfiguration.xml':
    ensure    => 'present',
    content   => template("${module_name}/config/jenkins.model.JenkinsLocationConfiguration.xml"),
    owner     => 'jenkins',
    group     => 'nogroup',
    mode      => '0644',
    notify    => Service['jenkins'],
  }

  file {'/var/lib/jenkins/org.jenkinsci.main.modules.sshd.SSHD.xml':
    ensure    => 'present',
    content   => template("${module_name}/config/org.jenkinsci.main.modules.sshd.SSHD.xml"),
    owner     => 'jenkins',
    group     => 'nogroup',
    mode      => '0644',
    notify    => Service['jenkins'],
  }

  file {'/var/lib/jenkins/hudson.tasks.Mailer.xml':
    ensure    => 'present',
    content   => template("${module_name}/config/hudson.tasks.Mailer.xml"),
    owner     => 'jenkins',
    group     => 'nogroup',
    mode      => '0644',
    notify    => Service['jenkins'],
  }

}
