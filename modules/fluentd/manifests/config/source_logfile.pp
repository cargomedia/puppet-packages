define fluentd::config::source_logfile (
  $path,
  $unit,
  $format,
  $format_firstline = '',
  $formats          = [],
  $fluentd_tag      = 'journal',
  $time_format      = undef,
  $time_key         = 'time',
  $read_from_head   = false,
) {

  $default_config = {
    path           => $path,
    tag            => $fluentd_tag,
    pos_file       => "/var/lib/fluentd/logfile-${title}_pos",
    path_key       => 'path',
    time_format    => $time_format,
    time_key       => $time_key,
    read_from_head => $read_from_head,
  }
  $format_config = logfile_formats($format, $format_firstline, $formats)

  fluentd::config::source { "logfile-${title}":
    type     => 'tail',
    config   => $default_config + $format_config,
    priority => 10,
  }

  fluentd::config::filter_record_transformer { "logfile-${title}":
    pattern  => $fluentd_tag,
    priority => 60,
    config   => {
      renew_record => true,
      enable_ruby  => true,
      keep_keys    => 'level,hostname,message',
    },
    record   => {
      journal => inline_template('${{"transport" => "logfile", "unit" => "<%= @unit %>", "logfile" => record["path"]}}'),
      extra   => inline_template('${record.reject {|key,value| ["level","hostname","message","path"].include? key}}'),
    },
  }
}
