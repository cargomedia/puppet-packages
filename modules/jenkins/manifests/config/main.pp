class jenkins::config::main(
  $num_executors
) {

  require 'jenkins::package'
  include 'jenkins::service'

  file { '/var/lib/jenkins/config.d':
    ensure    => 'directory',
    owner     => 'jenkins',
    group     => 'nogroup',
    mode      => '0644',
    purge     => true,
    recurse   => true,
    notify    => Exec['/var/lib/jenkins/config.xml'],
  }

  file { '/var/lib/jenkins/nodes':
    ensure    => 'directory',
    owner     => 'jenkins',
    group     => 'nogroup',
    mode      => '0644',
    purge     => true,
    recurse   => true,
    notify    => Service['jenkins'],
  }

  file {
    '/var/lib/jenkins/config.d/00-header.xml':
      ensure    => 'present',
      content   => template("${module_name}/config/main/00-header.xml"),
      owner     => 'jenkins',
      group     => 'nogroup',
      mode      => '0644',
      notify    => Exec['/var/lib/jenkins/config.xml'];

    '/var/lib/jenkins/config.d/99-footer.xml':
      ensure    => 'present',
      content   => template("${module_name}/config/main/99-footer.xml"),
      owner     => 'jenkins',
      group     => 'nogroup',
      mode      => '0644',
      notify    => Exec['/var/lib/jenkins/config.xml'];
  }

  exec { '/var/lib/jenkins/config.xml':
    command     => '/bin/cat /var/lib/jenkins/config.d/* > /var/lib/jenkins/config.xml',
    refreshonly => true,
    user        => 'jenkins',
    group       => 'nogroup',
    notify      => Service['jenkins'],
  }

  file { '/var/lib/jenkins/jenkins.model.JenkinsLocationConfiguration.xml':
    ensure    => 'present',
    content   => template("${module_name}/config/jenkins.model.JenkinsLocationConfiguration.xml"),
    owner     => 'jenkins',
    group     => 'nogroup',
    mode      => '0644',
    notify    => Service['jenkins'],
  }

  file { '/var/lib/jenkins/org.jenkinsci.main.modules.sshd.SSHD.xml':
    ensure    => 'present',
    content   => template("${module_name}/config/org.jenkinsci.main.modules.sshd.SSHD.xml"),
    owner     => 'jenkins',
    group     => 'nogroup',
    mode      => '0644',
    notify    => Service['jenkins'],
  }

  file { '/var/lib/jenkins/hudson.tasks.Mailer.xml':
    ensure    => 'present',
    content   => template("${module_name}/config/hudson.tasks.Mailer.xml"),
    owner     => 'jenkins',
    group     => 'nogroup',
    mode      => '0644',
    notify    => Service['jenkins'],
  }

}
