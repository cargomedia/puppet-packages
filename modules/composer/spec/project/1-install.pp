node default {

  composer::project{ 'phpunit/phpunit':
    target    => '/usr/local/lib/phpunit',
    user      => 'root',
    version   => '4.3.4',
    stability => 'dev',
  }
}
