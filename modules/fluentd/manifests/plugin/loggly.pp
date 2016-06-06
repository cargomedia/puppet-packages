class fluentd::plugin::loggly {

  require 'fluentd'

  ruby::gem { 'fluent-plugin-loggly':
    ensure => latest,
  }

}
