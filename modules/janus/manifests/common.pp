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

  sysctl::entry { 'janus':
    entries => {
      'net.core.rmem_default' => '33554432',
      'net.core.rmem_max'     => '33554432',
      'net.ipv4.udp_rmem_min' => '8192',
    }
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
