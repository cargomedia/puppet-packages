node default {

  include 'fluentd'

  ## Input from journal

  class { 'fluentd::config::source_journald': }

  ## Filters

  class { ['fluentd::config::filter_add_hostname', 'fluentd::config::filter_streamline_levels']: }

  # Dump everything  for test verification

  $output_config = @(END)
<match **>
  @type copy
  <store>
    @type file
    path /tmp/dump
    utc
  </store>
</match>
  | END

  @fluentd::config { 'dump_to_file':
    priority => 85,
    content  => inline_template($output_config),
  }

}
