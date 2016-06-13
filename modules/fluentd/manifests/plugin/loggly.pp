class fluentd::plugin::loggly {

  include 'fluentd'

  ruby::gem { 'fluent-plugin-loggly':
    ensure => latest,
  }

}
