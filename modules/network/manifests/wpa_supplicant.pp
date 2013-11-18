class network::wpa_supplicant {

  package {'wpasupplicant':
    ensure => present,
  }
}
