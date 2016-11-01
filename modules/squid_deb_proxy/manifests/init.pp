class squid_deb_proxy(
  $diskCacheRoot = '/var/cache/squid-deb-proxy',
  $listeningPort = 8123,
  $cacheOnlyAllowedMirrors = false,
  $accessOnlyAllowedMirrors = false,
) {

  include 'squid_deb_proxy::service'

  file {
    '/etc/squid-deb-proxy/':
      ensure => directory,
      owner  => '0',
      group  => '0',
      mode   => '0644';
    '/etc/squid-deb-proxy//mirror-dstdomain.acl.d/':
      ensure  => directory,
      owner   => '0',
      group   => '0',
      mode    => '0644',
      purge   => true,
      recurse => true,
      require => Package['squid-deb-proxy'],
      notify  => Service['squid-deb-proxy'];
    '/etc/squid-deb-proxy/squid-deb-proxy.conf':
      ensure  => file,
      content => template("${module_name}/squid-deb-proxy.conf.erb"),
      owner   => '0',
      group   => '0',
      mode    => '0644',
      notify => Service['squid-deb-proxy'],
      before  => Package['squid-deb-proxy'];
  }

  package { 'squid-deb-proxy':
    ensure   => present,
    provider => 'apt',
  }

  Squid_deb_proxy::Allowed_mirrors <||>
}
