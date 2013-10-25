node default {

  puppet::git-modules {'puppet-packages':
    source => 'https://github.com/cargomedia/puppet-packages.git',
    version => '6297f205d6e410c0d1b51d05af9f9f41394412be',
  }
}
