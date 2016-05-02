class nvidia {

  require 'apt'

  kernel::modprobe_blacklist { 'nvidia: blacklist and unload nouveau module':
    modules => ['nouveau'],
  }
  ->

  package { ['nvidia-346', 'nvidia-346-updates']:
    ensure   => present,
    provider => apt,
  }
  ->

  helper::script { 'nvidia: configure X server':
    content => template("${module_name}/configure_x.sh"),
    unless  => 'cat /etc/X11/xorg.conf | grep nvidia',
    require => Package['nvidia-346'],
  }
  ->

  xorg::config { 'nvidia: add module path':
    section => 'Files',
    key     => 'ModulePath',
    value   => '/usr/lib/nvidia-346/xorg/'
  }
  ->

  xorg::config { 'nvidia: add updates module path':
    section => 'Files',
    key     => 'ModulePath',
    value   => '/usr/lib/nvidia-346-updates/xorg/'
  }

  @bipbip::entry { 'logparser-nvidia-gpu':
    plugin  => 'log-parser',
    options => {
      'metric_group' => 'nvidia-gpu',
      'path' => '/var/log/syslog',
      'matchers' => [
        { 'name' => 'nvrm::xid',
          'regexp' => 'NVRM: Xid' }
      ]
    }
  }
}
