define fluentd::config::source_journald (
  $path        = '/run/log/journal/',
  $fluentd_tag = 'journal', # Can't be called "tag" in puppet
  $priority    = 10,
)
  {

    include 'fluentd::plugin::systemd'

    $config_template = @(EOT)
    <source>
      @type systemd
      path <%= @path %>
      tag <%= @fluentd_tag %>
      read_from_head true
      <storage>
        @type local
        persistent true
        path /var/lib/fluentd/journald_pos_<%= @name %>
      </storage>
    </source>

    <filter <%= @fluentd_tag %>.**>
      @type record_transformer
      renew_record true
      keep_keys level,MESSAGE,PRIORITY,_TRANSPORT,_UID,_GID,_PID,_SYSTEMD_UNIT
    </filter>
    |- EOT

    fluentd::config { "source-journald-${name}":
      priority => $priority,
      content  => inline_template($config_template),
    }

  }
