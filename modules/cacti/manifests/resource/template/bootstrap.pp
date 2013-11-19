class cacti::resource::template::bootstrap (
  $templateDir  = $cacti::params::templateDir
) inherits cacti::params {

  file {$templateDir:
    ensure => directory,
    require => Package['cacti'],
  }

  class {'cacti::resource::template::percona': }

  cacti::resource::template::install {'cacti_data_template_cm_entertainment_status.xml':
    content => template('cacti/data/templates/cacti_data_template_cm_entertainment_status.xml'),
    templateDir => $templateDir
  }

  cacti::resource::template::install {'cacti_graph_template_cm_entertainment_delay.xml':
    content => template('cacti/data/templates/cacti_graph_template_cm_entertainment_delay.xml'),
    templateDir => $templateDir
  }

  cacti::resource::template::install {'cacti_graph_template_cm_entertainment_queue.xml':
    content => template('cacti/data/templates/cacti_graph_template_cm_entertainment_queue.xml'),
    templateDir => $templateDir
  }

  cacti::resource::template::install {'tcp_connection_status.xml':
    content => template('cacti/data/templates/tcp_connection_status.xml'),
    templateDir => $templateDir
  }
}