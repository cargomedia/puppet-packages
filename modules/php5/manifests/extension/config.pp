define php5::extension::config(
  $extension = $title,
  $settings = {},
){

  file {"/etc/php5/conf.d/${extension}.ini":
    ensure => file,
    content => template("php5/extension/${extension}/conf.ini"),
    owner => '0',
    group => '0',
    mode => '0644',
  }
}
