class nvidia {

  require 'apt'

  package { 'nvidia-346':
    ensure   => present,
    provider => apt,
  }
  ->

  helper::script { 'nvidia: configure X server':
    content => template("${module_name}/configure_x.sh"),
    unless  => 'cat /etc/X11/xorg.conf | grep nvidia',
    require => Package['nvidia-346'],
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
