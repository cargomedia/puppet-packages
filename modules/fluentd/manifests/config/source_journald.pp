class fluentd::config::source_journald (
  $path           = '/run/log/journal/',
  $fluentd_tag    = 'journal', # Can't be called "tag" in puppet
  $priority       = 10,
  $read_from_head = false,
) {

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

    fluentd::config::filter_record_transformer { 'transformer-journald':
      pattern  => "${fluentd_tag}.**",
      priority => 60,
      config   => {
        renew_record => true,
        enable_ruby  => true,
        keep_keys    => 'level,hostname,message,journal',
      },
      record   => {
        message => '${record["MESSAGE"]}',
        journal => '${r=record;{"transport" => r["_TRANSPORT"], "unit" => r["_SYSTEMD_UNIT"], "pid" => r["_PID"], "uid" => r["_UID"]}}'
      },
    }

    class { 'fluentd::config::filter_streamline_priorities':
      pattern => "${fluentd_tag}.**",
    }

    $heartbeat_service = 'journald-heartbeatd'

    file { "/usr/local/bin/${heartbeat_service}":
      ensure   => file,
      content  => template("${module_name}/${heartbeat_service}.sh.erb"),
      owner    => '0',
      group    => '0',
      mode     => '0755',
      notify   => Daemon[$heartbeat_service],
    }

    daemon { $heartbeat_service:
      binary  => "/usr/local/bin/${heartbeat_service}",
      require => File["/usr/local/bin/${heartbeat_service}"],
    }
  }
