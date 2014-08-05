node default {

  class {'puppet::master':
    puppetfile => '
      forge "https://forgeapi.puppetlabs.com"
      mod "puppetlabs/mysql", :git => "git://github.com/puppetlabs/puppetlabs-mysql.git"',
    puppetfile_hiera_data_dir => '/foobar'
  }
}
