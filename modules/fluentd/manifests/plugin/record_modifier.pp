class fluentd::plugin::record_modifier {

  require 'fluentd'

  ruby::gem { 'fluent-plugin-record-modifier':
    ensure => latest,
  }

}
