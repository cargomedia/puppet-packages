class newrelic::php5(
  $licenseKey                 = undef,
  $appname                    = undef,
  $enabled                    = false,
  $browser_monitoring_enabled = false
) {

  if !($licenseKey) { fail("You need to provide an installation key to New Relic") }

  apt::source { 'new-relic':
    entries => ['deb http://apt.newrelic.com/debian/ newrelic non-free'],
    keys => { 'newrelic' => {
        key     => '548C16BF',
        key_url => 'http://download.newrelic.com/548C16BF.gpg',
      }
    }
  }
  ->
  package { 'newrelic-php5':
    ensure => present
  }
  ->
  exec { 'postinstall':
    command => 'bash -c "NR_INSTALL_SILENT=yes, NR_INSTALL_KEY=$licenseKey newrelic-install install"',
    path => ['/usr/bin', '/bin'],
  }
  ->
  file { ['/etc/php5', '/etc/php5/conf.d/']:
    ensure => directory,
    owner   => '0',
    group   => '0',
    mode    => '0755',
  }
  ->
  file { '/etc/php5/conf.d/newrelic.ini':
    ensure  => file,
    owner   => '0',
    group   => '0',
    mode    => '0644',
    content => template("${module_name}/newrelic-ini"),
  }

}
