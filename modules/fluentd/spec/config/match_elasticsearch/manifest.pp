node default {

  fluentd::config::match_elasticsearch { 'main':
    pattern         => '**',
    priority        => 50,
    hosts           => ['https://foo:bar@localhost:9200', 'https://foo:bar@localhost:9201'],
    index_name      => undef,
    type_name       => 'type-foo',
    include_tag_key => true,
    logstash_format => true,
    time_precision  => 5,
    flush_interval  => 2,
  }
}
