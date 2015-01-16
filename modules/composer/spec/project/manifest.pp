node default {

  composer::project{ 'composer/satis':
    target    => '/var/lib/satis/satis',
    user      => 'root',
    home      => '/var/lib/satis',
    stability => 'dev',
  }
}
