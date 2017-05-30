class fluentd::config::source_journald (
  $path           = '/run/log/journal/',
  $fluentd_tag    = 'journal', # Can't be called "tag" in puppet
  $priority       = 10,
  $read_from_head = false,
)
  {

    include 'fluentd::plugin::systemd'

    $config_template = @(EOT)
    <source>
      @type systemd
      path <%= @path %>
      tag <%= @fluentd_tag %>
      read_from_head <%= @read_from_head %>
      <storage>
        @type local
        persistent true
        path /var/lib/fluentd/journald_pos
      </storage>
    </source>
    |- EOT

    fluentd::config { 'source-journald':
      priority => $priority,
      content  => inline_template($config_template),
    }

    $tranformer_config = @(EOT)
    <filter <%= @fluentd_tag %>.**>
      @type record_transformer
      renew_record true
      enable_ruby true
      keep_keys level,hostname,message,journal
      <record>
        message ${record["MESSAGE"]}
        journal ${r=record;{'transport' => r["_TRANSPORT"], 'unit' => r["_SYSTEMD_UNIT"], 'pid' => r["_PID"], 'uid' => r["_UID"]}}
      </record>
    </filter>
    |- EOT

    fluentd::config { 'tranformer-journald':
      priority => 60,
      content  => inline_template($tranformer_config)
    }

    class { 'fluentd::config::filter_streamline_priorities':
      pattern => "${fluentd_tag}.**",
    }
  }
