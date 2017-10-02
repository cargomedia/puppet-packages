class fluentd::plugin::elasticsearch {

  include 'fluentd'

  ruby::gem { 'fluent-plugin-elasticsearch':
    ensure => latest,
  }
}
