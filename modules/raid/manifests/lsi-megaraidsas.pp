class raid::lsi-megaraidsas {

  apt::source {'hwraid_le-vert':
    entries => ['deb http://hwraid.le-vert.net/debian squeeze main'],
    keys => {'le-vert' => {
      key     => '23B3D3B4',
      key_url => 'http://hwraid.le-vert.net/debian/hwraid.le-vert.net.gpg.key',
      }
    }
  }
  ->

  package {'megaraid-status':
    ensure => present
  }
  ->

  service {'megaraidsas-statusd':
    hasstatus => false,
  }
  ->

  monit::entry {'megaraidsas-statusd':
    content => template('raid/lsi-megaraidsas/monit')
  }

}