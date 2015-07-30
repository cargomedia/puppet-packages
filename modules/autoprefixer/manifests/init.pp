class autoprefixer(
  $caniuse_version = 'latest'
) {

  require 'nodejs'

  package { 'autoprefixer':
    ensure   => '5.2.0',
    provider => 'npm',
  }

  nodejs::package { 'caniuse-db':
    path    => '/usr/lib/node_modules/autoprefixer/node_modules/autoprefixer-core',
    version => $caniuse_version,
    require => Package['autoprefixer'],
  }

}
