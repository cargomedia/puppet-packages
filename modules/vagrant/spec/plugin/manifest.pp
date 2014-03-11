node default {

  vagrant::plugin {'vagrant-phpstorm-tunnel':
    user => 'root',
    user_home => '/root',
  }

}
