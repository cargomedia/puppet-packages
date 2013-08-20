class apt::sources($lists = {}) {

  include 'apt::update'

  file { '/etc/apt/sources.list':
    source => "puppet:///modules/${module_name}/sources",
    ensure => file,
    group => '0',
    owner => '0',
    mode => '0644',
    notify => Exec['apt_update']
  }


}
