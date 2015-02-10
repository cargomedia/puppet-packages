node default {

  composer::project{ 'seld/jsonlint':
    target    => '/usr/local/lib/jsonlint',
    user      => 'root',
    version   => '1.3.1',
    stability => 'dev',
  }
}
