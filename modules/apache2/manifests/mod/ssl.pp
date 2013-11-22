class apache2::mod::ssl {

  apache2::mod {'ssl':
    configuration => template('apache2/mod/ssl.conf'),
  }

  file {'/etc/apache2/ssl':
    ensure => directory,
    owner => '0',
    group => '0',
    mode => '755',
    require => Apache2::Mod['ssl'],
  }

  file {'/etc/apache2/ssl-ca':
    ensure => directory,
    owner => '0',
    group => '0',
    mode => '755',
    require => Apache2::Mod['ssl'],
  }
}
