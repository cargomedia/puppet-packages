class fluentd::plugin::rewrite_tag {

  include 'fluentd'

  ruby::gem { 'fluent-plugin-rewrite-tag-filter':
    ensure => latest,
  }

}
