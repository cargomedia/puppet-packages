class lvm::expand::raid::adaptec {

  include '::raid::adaptec'

  file {'/root/bin/expand-raid.sh':
    ensure => file,
    content => template('lvm/expand/raid-adaptec'),
    require => Class['::raid::adaptec', 'lvm::package', 'lvm::base::xfs'],
  }
}