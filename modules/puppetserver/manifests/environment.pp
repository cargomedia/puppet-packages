define puppetserver::environment (
  $manifest = undef,
  $puppetfile = undef,
) {

  include 'puppetserver'

  $directory = "/etc/puppetlabs/code/environments/${name}"

  file { [$directory, "${directory}/manifests", "${directory}/modules"]:
    ensure  => directory,
    group   => '0',
    owner   => '0',
    mode    => '0644',
  }

  if ($manifest) {
    file { "${directory}/manifests/site.pp":
      ensure  => file,
      content => $manifest,
      group   => '0',
      owner   => '0',
      mode    => '0644',
      before  => Package['puppetserver'],
      notify  => Service['puppetserver'],
    }
  }

  if ($puppetfile) {
    puppet::puppetfile { $directory :
      content => $puppetfile,
      require => File["${directory}/modules"],
      before  => Package['puppetserver'],
      notify  => Service['puppetserver'],
    }
  }

}
