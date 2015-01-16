node default {

  composer::project{ 'phpunit/phpunit':
    user      => 'root',
    version   => '4.4.0',
    stability => 'dev',
  }
}
