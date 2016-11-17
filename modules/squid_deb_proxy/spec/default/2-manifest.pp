node default {

  ensure_packages(['fontconfig', 'bzip2', 'htop'], { ensure => 'installed', provider => 'apt' })

}
