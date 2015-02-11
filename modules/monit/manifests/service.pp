class monit::service {

  require 'monit'

  service { 'monit':
    hasrestart => true,
    enable     => true,
  }

  @bipbip::entry { 'monit':
    plugin  => 'monit',
    options => { },
  }
}
