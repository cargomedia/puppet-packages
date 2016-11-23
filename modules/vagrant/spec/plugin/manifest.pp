node default {

  vagrant::plugin { 'vagrant-proxyconf':
    user      => 'root',
    user_home => '/root',
  }

}
