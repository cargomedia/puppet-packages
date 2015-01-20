node default {

  composer::project{ 'phpunit/phpunit':
    target    => '/usr/local/lib/phpunit',
    user      => 'root',
    version   => '4.4.0',
    stability => 'dev',
  }
}
