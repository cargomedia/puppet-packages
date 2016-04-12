node default {

  puppetserver::environment { 'foo':
    puppetfile => '
      forge "https://forgeapi.puppetlabs.com"
      mod "puppetlabs/mysql", :git => "git://github.com/puppetlabs/puppetlabs-mysql.git"',
  }
}
