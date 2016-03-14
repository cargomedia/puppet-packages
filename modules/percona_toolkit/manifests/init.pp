class percona_toolkit {

  require 'apt'

  $version = '2.2.5-2'
  $version_nobuild = regsubst($version, '-[^-]+$', '')

  helper::script { 'install percona-toolkit':
    content => template("${module_name}/install.sh"),
    unless  => "pt-online-schema-change --version | grep -w ${version_nobuild}",
    require => Class['apt::update'],
  }
}
