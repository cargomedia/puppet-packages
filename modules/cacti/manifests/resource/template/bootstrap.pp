class cacti::resource::template::bootstrap (
  $template_dir  = $cacti::params::template_dir
) inherits cacti::params {

  file {$template_dir:
    ensure => directory,
    require => Package['cacti'],
  }

  class {'cacti::resource::template::percona': }

  Cacti::Resource::Template::Install {
    template_dir => $template_dir
  }

  cacti::resource::template::install {'cacti_data_template_cm_entertainment_status.xml':
    content => template('cacti/data/templates/cacti_data_template_cm_entertainment_status.xml'),
  }

  cacti::resource::template::install {'cacti_graph_template_cm_entertainment_delay.xml':
    content => template('cacti/data/templates/cacti_graph_template_cm_entertainment_delay.xml'),
  }

  cacti::resource::template::install {'cacti_graph_template_cm_entertainment_queue.xml':
    content => template('cacti/data/templates/cacti_graph_template_cm_entertainment_queue.xml'),
  }

  cacti::resource::template::install {'tcp_connection_status.xml':
    content => template('cacti/data/templates/tcp_connection_status.xml'),
  }

}