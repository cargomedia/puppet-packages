node default {

  class {'puppet::master':
    puppetfile => '
      mod "cargomedia/openssl", :git => ":git@github.com:cargomedia/puppet-packages.git"',
    hiera_data_repo => '/foobar'
  }

}
