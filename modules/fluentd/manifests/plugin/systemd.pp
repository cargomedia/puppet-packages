class fluentd::plugin::systemd {

  include 'fluentd'

  ruby::gem { 'fluent-plugin-systemd':
    ensure => latest,
  }

}
