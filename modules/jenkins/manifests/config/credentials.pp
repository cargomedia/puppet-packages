class jenkins::config::credentials {

  require 'jenkins::package'
  include 'jenkins::service'

  file { '/var/lib/jenkins/credentials.d':
    ensure    => 'directory',
    owner     => 'jenkins',
    group     => 'nogroup',
    mode      => '0755',
    purge     => true,
    recurse   => true,
    notify    => Exec['/var/lib/jenkins/credentials.xml'],
  }

  file {
    '/var/lib/jenkins/credentials.d/00-header.xml':
      ensure    => 'present',
      content   => template("${module_name}/config/credentials/00-header.xml"),
      owner     => 'jenkins',
      group     => 'nogroup',
      mode      => '0644',
      notify    => Exec['/var/lib/jenkins/credentials.xml'];

    '/var/lib/jenkins/credentials.d/99-footer.xml':
      ensure    => 'present',
      content   => template("${module_name}/config/credentials/99-footer.xml"),
      owner     => 'jenkins',
      group     => 'nogroup',
      mode      => '0644',
      notify    => Exec['/var/lib/jenkins/credentials.xml'];
  }

  exec { '/var/lib/jenkins/credentials.xml':
    command     => '/bin/cat /var/lib/jenkins/credentials.d/* > /var/lib/jenkins/credentials.xml',
    refreshonly => true,
    user        => 'jenkins',
    group       => 'nogroup',
    notify      => Service['jenkins'],
  }

}
