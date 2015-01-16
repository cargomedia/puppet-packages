node default {

  composer::project{ 'phpunit/phpunit':
    user      => 'root',
    version   => '4.3.4',
    stability => 'dev',
  }
}
