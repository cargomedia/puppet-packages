define puppetmaster::environment (
  $puppetfile = undef
) {

  include 'puppetmaster'

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
