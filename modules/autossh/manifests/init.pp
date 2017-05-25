class autossh (
  $local_port,
  $remote_port      = nil,
  $remote_port      = nil,
  $remote           = { },
  $local_forwarding = false,
  $local_host       = '127.0.0.1',
) {

  require 'apt'

  package { 'autossh':
    ensure   => present,
    provider => 'apt',
  }

}
