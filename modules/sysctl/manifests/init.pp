class sysctl($entries = nil) {

  $sysctlFile = '/etc/sysctl.d/local.conf'

  file { $sysctlFile:
    ensure => file,
    alias => 'sysctl file',
    owner => '0',
    group => '0',
    mode => '0644',
  }

  exec { 'sysctl -p':
    path => '/sbin',
    alias => 'sysctl',
    refreshonly => true,
    subscribe => File['sysctl file'],
  }

  if $entries != nil {
    create_resources(sysctl::entry, $entries, { sysctlFile => $sysctlFile })
  }
}
