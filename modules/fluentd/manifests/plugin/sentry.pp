class fluentd::plugin::sentry {

  include 'fluentd'

  # Version 0.14.0 breaks wheezy
  # Dep strptime requires Ruby version ~> 2.0
  $fluent_plugin_sentry_version = $::facts['lsbdistcodename'] ? {
    'wheezy' => '0.12.26',
    default  => latest,
  }

  ruby::gem { 'fluent-plugin-sentry':
    ensure => latest,
  }

}
