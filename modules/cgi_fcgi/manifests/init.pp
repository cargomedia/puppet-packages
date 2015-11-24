class cgi_fcgi {

  require 'apt'

  package { 'libfcgi0ldbl':
    ensure => present,
    provider => 'apt',
  }
}
