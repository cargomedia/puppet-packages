node default {

  include 'fluentd'

  fluentd::config::source_logfile { 'simple':
    path           => '/tmp/simple.log',
    unit           => 'simple.test',
    format         => '/(?<time>\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}) \[(?<level>\S+)\] (?<message>.*) val:(?<custom>.*)/',
    time_format    => '%Y-%m-%d %H:%M:%S',
    read_from_head => true,
  }

  fluentd::config::match_copy { 'dump_to_file':
    pattern  => '**',
    priority => 85,
    stores   => [{
      'type'   => 'file',
      'path'   => '/tmp/dump',
      'format' => 'json',
    }]
  }
}
