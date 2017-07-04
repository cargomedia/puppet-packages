define fluentd::config::source_logfile (
  $path,
  $unit,
  $format,
  $format_firstline = '',
  $formats          = [],
  $fluentd_tag      = 'logfile',
  $time_format      = undef,
  $time_key         = 'time',
  $read_from_head   = false,
  $config          = { },
) {

  $internal_tag = "logfile.${title}"

  $default_config = {
    path           => $path,
    tag            => $internal_tag,
    pos_file       => "/var/lib/fluentd/logfile-${title}_pos",
    path_key       => 'path',
    time_format    => $time_format,
    time_key       => $time_key,
    read_from_head => $read_from_head,
  }
  $format_config = logfile_formats($format, $format_firstline, $formats)

  fluentd::config::source { "logfile-${title}":
    type     => 'tail',
    config   => $default_config + $config + $format_config,
    priority => 10,
  }

  fluentd::config::filter_record_transformer { "logfile-${title}":
    pattern  => $internal_tag,
    priority => 11,
    config   => {
      renew_record => true,
      enable_ruby  => true,
      keep_keys    => 'level,message',
    },
    record   => {
      journal => inline_template('${{"transport" => "logfile", "unit" => "<%= @unit %>", "logfile" => record["path"]}}'),
      extra   => inline_template('${record.reject {|key,value| ["level","message","path"].include? key}}'),
    },
  }

  fluentd::config::match_retag { "logfile-${title}":
    pattern  => $internal_tag,
    priority => 12,
    config   => {
      rewriterule1 => "journal .+ ${fluentd_tag}"
    }
  }
}
