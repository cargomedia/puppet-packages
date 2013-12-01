node default {

  class {'puppet::agent':
    tag => 'bootstrap',
  }

  # Adding monit for puppet::agent's monit-entry not to fail during bootstrapping
  # See https://github.com/cargomedia/puppet-packages/issues/232
  class {'monit':
    tag => 'bootstrap',
  }

  include hiera_array('classes', [])
}
