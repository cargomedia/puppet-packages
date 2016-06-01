class fluentd::plugin::sentry {

  include 'fluentd'

  # Require needed to ensure fluentd installs in a Wheezy-suitable fashion
  ruby::gem { 'fluent-plugin-sentry':
    ensure => latest,
    require => Ruby::Gem['fluentd'],
  }

}
