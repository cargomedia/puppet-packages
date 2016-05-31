class nvidia {

  require 'apt'

  kernel::modprobe_blacklist { 'nvidia: blacklist and unload nouveau module':
    modules => ['nouveau'],
    before  => Package['nvidia-346'],
  }

  package { 'nvidia-346':
    ensure   => present,
    provider => apt,
  }

  exec { 'nvidia: configure X server':
    provider    => shell,
    command     => 'nvidia-xconfig',
    unless      => 'cat /etc/X11/xorg.conf | grep nvidia-xconfig',
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    require     => Package['nvidia-346'],
  }
}
