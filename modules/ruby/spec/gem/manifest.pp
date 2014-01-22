node default {

  ruby::gem { 'deep_merge':
    ensure => present,
  }
}
