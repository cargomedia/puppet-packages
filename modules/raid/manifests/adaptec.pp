class raid::adaptec {

  apt::source {'hwraid_le-vert':
  entries => ['deb http://hwraid.le-vert.net/debian squeeze main'],
    keys => {'le-vert' => {
        key     => '23B3D3B4',
        key_url => 'http://hwraid.le-vert.net/debian/hwraid.le-vert.net.gpg.key',
      }
    }
  }
  ->

  package {'arcconf':
    ensure => present
  }
  ->

  package {'aacraid-status':
    ensure => present
  }
  ->

  service {'aacraid-statusd':
    hasstatus => false,
  }

  @monit::entry {'aacraid-statusd':
    content => template('raid/adaptec/monit'),
    require => Service['aacraid-statusd'],
  }

  helper::script {'set hard drive write cache off if adaptec raid':
    content => template('raid/adaptec/set-write-cache-off.sh'),
    unless => 'false',
    require => Package['arcconf'],
  }
}
