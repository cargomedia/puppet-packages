class cgroups {

  include 'augeas'

  package { 'cgroup-bin':
    ensure => present,
  }

  mount::entry { 'mount cgroup':
    source  => 'cgroup',
    target  => '/sys/fs/cgroup',
    type    => 'cgroup',
    options => 'defaults',
    mount   => true,
    require => Package['cgroup-bin'],
  }

  file { '/etc/cgconfig.conf':
    ensure => file,
    mode   => '0644',
    owner  => '0',
    group  => '0',
  }

  file { 'augeas-lens':
    ensure => file,
    name   => '/usr/share/augeas/lenses/dist/cgconfig.aug',
    source => 'puppet:///modules/cgroups/cgconfig.aug',
  }

  helper::service { 'cgconfig-apply':
    init_file_content => template("${module_name}/init"),
    notify            => Service['cgconfig-apply'],
    require           => File['/etc/cgconfig.conf'],
  }


  service { 'cgconfig-apply':
    enable => true,
  }

}
