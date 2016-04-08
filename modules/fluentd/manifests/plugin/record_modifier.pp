class fluentd::plugin::record_modifier {

  include 'fluentd'

  ruby::gem { 'fluent-plugin-record-modifier':
    ensure => latest,
  }

}
