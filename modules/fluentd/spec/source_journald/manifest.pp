node default {

  include 'fluentd'
  class { 'systemd::config::journald':
    fluentd_output => true,
  }

  # Dump everything  for test verification

  $output_config = @(END)
<match **>
  @type copy
  <store>
    @type file
    path /tmp/dump
    format json
  </store>
</match>
  | END

  fluentd::config { 'dump_to_file':
    priority => 85,
    content  => inline_template($output_config),
  }
}
