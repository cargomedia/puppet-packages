class janus::common (
  $src_version = undef,
) {

  require 'apt'
  require 'apt::source::cargomedia'

  user { 'janus':
    ensure => present,
    system => true,
  }

  if $src_version {
    class { 'janus::source':
      version => $src_version,
    }
  } else {
    package { 'janus':
      provider => 'apt',
    }
  }
}
