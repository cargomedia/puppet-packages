class monit::service {

  require 'monit'

  service {'monit':
    hasstatus => false,
  }
}
