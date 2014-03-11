node default {

  vagrant::plugin {'vagrant-phpstorm-tunnel':
    user => 'root',
    user_home => '/root',
    version => '0.1.0',
  }

}
