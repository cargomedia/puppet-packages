class network::wpa_supplicant {

  require 'apt'

  package { 'wpasupplicant':
    ensure => present,
    provider => 'apt',
  }
}
