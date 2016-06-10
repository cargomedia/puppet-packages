class fluentd::plugin::sentry {

  require 'fluentd'

  ruby::gem { 'fluent-plugin-sentry':
    ensure => latest,
  }

}
