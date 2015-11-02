node default {

  file { '/tmp/foo':
    ensure => directory,
  }

  puppet::puppetfile { '/tmp/foo':
    content => '
      forge "https://forgeapi.puppetlabs.com"
      mod "puppetlabs/mysql", :git => "git://github.com/puppetlabs/puppetlabs-mysql.git"',
  }
}
