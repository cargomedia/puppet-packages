class cm_janus::common (
  $version = latest
) {

  require 'nodejs'
  require 'build::gpp'
  require 'mjr_convert'
  require 'lame'

  user { 'cm-janus':
    ensure  => present,
    system  => true,
  }

  package { 'cm-janus':
    ensure   => $version,
    provider => 'npm',
  }
}
