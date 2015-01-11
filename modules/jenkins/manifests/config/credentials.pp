class jenkins::config::credentials {

  require 'jenkins::package'
  include 'jenkins::service'

  file {'/var/lib/jenkins/credentials.d':
    ensure    => 'directory',
    owner     => 'jenkins',
    group     => 'nogroup',
    mode      => '0755',
    purge     => true,
  }

  file {'/var/lib/jenkins/credentials.d/_header.xml':
    ensure    => 'present',
    content   => template("${module_name}/config/credentials/_header.xml"),
    owner     => 'jenkins',
    group     => 'nogroup',
    mode      => '0644',
    notify    => Exec['/var/lib/jenkins/credentials.xml'],
  }

  file {'/var/lib/jenkins/credentials.d/_footer.xml':
    ensure    => 'present',
    content   => template("${module_name}/config/credentials/_footer.xml"),
    owner     => 'jenkins',
    group     => 'nogroup',
    mode      => '0644',
    notify    => Exec['/var/lib/jenkins/credentials.xml'],
  }

  exec {'/var/lib/jenkins/credentials.xml':
    command     => '/bin/cat /var/lib/jenkins/credentials.d/_header.xml /var/lib/jenkins/credentials.d/* /var/lib/jenkins/credentials.d/_footer.xml > /var/lib/jenkins/credentials.xml',
    refreshonly => true,
    user        => 'jenkins',
    group       => 'nogroup',
    require     => [
      File['/var/lib/jenkins/credentials.d'],
      File['/var/lib/jenkins/credentials.d/_header.xml'],
      File['/var/lib/jenkins/credentials.d/_footer.xml'],
    ],
    subscribe   => [
      File['/var/lib/jenkins/credentials.d/_header.xml'],
      File['/var/lib/jenkins/credentials.d/_footer.xml']
    ],
    notify      => Service['jenkins'],
  }

}
