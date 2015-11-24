class network::wpa_supplicant {

  require 'apt'

  package { 'wpasupplicant':
    provider => 'apt',
    ensure => present,
  }
}
