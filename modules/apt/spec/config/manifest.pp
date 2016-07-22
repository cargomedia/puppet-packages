node default {

  apt::config { "998-some-uniq-name":
    content => 'DPkg::Pre-Invoke {"touch /var/lib/apt/apt-dpkg-pre-stamp-$(date +%s)";}',
  }
  ->

  apt::config { "999-some-uniq-name":
    content => 'DPkg::Post-Invoke {"touch /var/lib/apt/apt-dpkg-post-stamp-$(date +%s)";}',
  }
  ->

  exec { 'apt::upgrade':
    command => 'sudo apt-get upgrade -yy',
    path    => ['/bin','/usr/bin', '/usr/local/bin'],
  }

}
