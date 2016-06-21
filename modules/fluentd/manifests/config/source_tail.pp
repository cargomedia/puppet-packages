define fluentd::config::source_tail (
  $path,
  $fluentd_tag, # Can't be called "tag" in puppet
  $format = 'json',
  $time_key = undef,
  $time_format = undef,
  $priority = 10,
) {

  fluentd::config::source{ $title:
    type     => 'tail',
    config   => {
      path        => $path,
      pos_file    => '/var/lib/fluentd/tail_pos',
      format      => $format,
      time_key    => $time_key,
      time_format => $time_format,
      tag         => $fluentd_tag,
    },
    priority => $priority,
  }

}
