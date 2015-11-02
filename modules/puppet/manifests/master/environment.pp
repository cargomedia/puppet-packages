define puppet::master::environment (
  $puppetfile
) {

  include 'puppet::master'

  $directory = "/etc/puppet/environments/${name}"

  file { $directory:
    ensure => directory,
    group   => '0',
    owner   => '0',
    mode    => '0644',
  }

  puppet::puppetfile { $directory :
    content => $puppetfile,
  }

}
