node default {

  vagrant::plugin { 'vagrant-proxyconf':
    user      => 'root',
    user_home => '/root',
    version   => '1.5.1',
  }

}
