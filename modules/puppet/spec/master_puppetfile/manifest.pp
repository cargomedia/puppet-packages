node default {

  class {'puppet::master':
    puppetfile => '
      mod "mysql", :git => "git://github.com/puppetlabs/puppetlabs-mysql.git"
    ',
  }

}
