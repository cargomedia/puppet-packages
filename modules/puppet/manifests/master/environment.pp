define puppet::master::environment (
  $puppetfile = undef
) {

  include 'puppet::master'

  $directory = "/etc/puppet/environments/${name}"

  file { $directory:
    ensure  => directory,
    group   => '0',
    owner   => '0',
    mode    => '0644',
  }

  if ($puppetfile) {
    puppet::puppetfile { $directory :
      content => $puppetfile,
    }
  }

}
