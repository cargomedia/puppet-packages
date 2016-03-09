class janus::common (
  $src_version = undef,
  $src_repo = undef,
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
      repo    => $src_repo,
    }
  } else {
    package { 'janus':
      provider => 'apt',
    }
  }

}
