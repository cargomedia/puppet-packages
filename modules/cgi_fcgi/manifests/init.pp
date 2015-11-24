class cgi_fcgi {

  require 'apt'

  package { 'libfcgi0ldbl':
    provider => 'apt',
    ensure => present,
  }
}
