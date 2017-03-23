class fluentd::config::source_journald (
  $path        = '/run/log/journal/',
  $fluentd_tag = 'journal', # Can't be called "tag" in puppet
  $priority    = 10,
  $pos_file = true,
)
  {

  include 'fluentd::plugin::systemd'

  $pos_file_template = @(EOT)
<storage>
  @type local
  persistent true
  path /var/lib/fluentd/journald_pos
</storage>
| EOT


  $config_template = @(EOC)
<source>
  @type systemd
  path <%= @path %>
  tag <%= @fluentd_tag %>
  read_from_head true
  <%= @pos_file_template if @pos_file %>
</source>
| EOC

  @fluentd::config { 'source-journald':
    priority => $priority,
    content  => inline_template($config_template),
  }

}
