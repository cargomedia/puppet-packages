class newrelic::php5 ($license_key, $appname = undef, $enabled = false, $browser_monitoring_enabled = false) {

  $version = '3.6.5.178'

  include 'php5'

  apt::source {'new-relic':
    entries => ['deb http://apt.newrelic.com/debian/ newrelic non-free'],
    keys => {'newrelic' => {
        key     => '548C16BF',
        key_url => 'http://download.newrelic.com/548C16BF.gpg',
      }
    }
  }
  ->

  package {'newrelic-php5':
    ensure => present
  }
  ->

  exec {'new-relic postinstall':
    command => 'bash -c "NR_INSTALL_SILENT=yes, NR_INSTALL_KEY=$licenseKey newrelic-install install"',
    unless => 
    path => ['/usr/bin', '/bin'],
  }
  ->

  file { '/etc/php5/conf.d/newrelic.ini':
    ensure  => file,
    content => template('newrelic/php/config'),
    owner   => '0',
    group   => '0',
    mode    => '0644',
    before  => Package['php5-common'],
  }
}
