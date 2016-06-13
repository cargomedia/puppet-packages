class fluentd::plugin::sentry {

  include 'fluentd'

  ruby::gem { 'fluent-plugin-sentry':
    ensure => latest,
  }

}
