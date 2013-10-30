define apache2::ssl-ca ($host = $name, $content) {

  require 'apache2::mod::ssl'

  file {"/etc/apache2/ssl-ca/${host}":
    ensure => present,
    content => $content,
    group => 'www-data',
    owner => 'www-data',
    mode => '0644',
    require => Class['apache2::mod::ssl']
  }
  ->

  exec {"/etc/apache2/ssl-ca/${host}":
    provider => shell,
    command => "ln -s ${host} $(openssl x509 -noout -hash -in ${host}).0",
    unless => "test -L $(openssl x509 -noout -hash -in ${host}).0",
    cwd => '/etc/apache2/ssl-ca/'
  }
}
