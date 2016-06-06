class fluentd::plugin::forest {

  require 'fluentd'

  ruby::gem { 'fluent-plugin-forest':
    ensure => latest,
  }

}
