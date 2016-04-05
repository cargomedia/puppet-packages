class fluentd::plugin::forest {

  include 'fluentd'

  ruby::gem { 'fluent-plugin-forest':
    ensure => latest,
  }

}
