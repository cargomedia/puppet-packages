class php5::extension::apc (
  $version = '3.1.13',
  $stat = true,
  $shim_size = '256M',
  $enable_cli = true,
  $configureParams = '--enable-apc-mmap --enable-apc-pthreadmutex --disable-apc-debug --disable-apc-filehits --disable-apc-spinlocks'
) {

  require 'build'
  require 'php5'

  helper::script {'install php5::apc':
    content => template('php5/apc/install.sh'),
    unless => "php --re apc | grep 'apc version' | grep ' ${version} '",
    require => Class['php5'],
  }
  ->

  file { '/etc/php5/conf.d/apc.ini':
    ensure => file,
    content => template('php5/apc/conf.ini'),
    owner => '0',
    group => '0',
    mode => '0644',
  }
}
