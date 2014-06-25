class monit::service {

  require 'monit'

  service {'monit':
    hasrestart => true,
  }

  @bipbip::entry {'monit':
    plugin => 'monit',
    options => {},
  }
}
