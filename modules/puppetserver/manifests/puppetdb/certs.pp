class puppetserver::puppetdb::certs (
) {

  $path_ssl_private = '/etc/puppetlabs/puppetdb/ssl/private.pem'
  $path_ssl_public = '/etc/puppetlabs/puppetdb/ssl/public.pem'
  $path_ssl_ca = '/etc/puppetlabs/puppetdb/ssl/ca.pem'

  Exec {
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }

  file { '/etc/puppetlabs/puppetdb/ssl':
    ensure  => directory,
    owner   => 'puppetdb',
    group   => 'puppetdb',
    mode    => '0700',
    require => Package['puppetdb'],
  }
  ->

  exec { 'ensure puppet master certs are created':
    command => 'systemctl start puppetserver',
    unless  => 'test -f $(puppet master --configprint hostprivkey)',
    path    => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    require => Class['puppetserver']
  }
  ->

  exec { $path_ssl_private:
    command => "cp $(puppet master --configprint hostprivkey) ${path_ssl_private} && chown puppetdb:puppetdb ${path_ssl_private} && chmod 600 ${path_ssl_private}",
    creates => $path_ssl_private,
    notify  => Service['puppetdb'],
  }
  ->

  exec { $path_ssl_public:
    command => "cp $(puppet master --configprint hostcert) ${path_ssl_public} && chown puppetdb:puppetdb ${path_ssl_public} && chmod 600 ${path_ssl_public}",
    creates => $path_ssl_public,
    notify  => Service['puppetdb'],
  }
  ->

  exec { $path_ssl_ca:
    command => "cp $(puppet master --configprint localcacert) ${path_ssl_ca} && chown puppetdb:puppetdb ${path_ssl_ca} && chmod 600 ${path_ssl_ca}",
    creates => $path_ssl_ca,
    notify  => Service['puppetdb'],
  }


}
