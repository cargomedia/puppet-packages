node default {

  cm_janus { 'cm-janus':
    http_server_port    =>  8800,
    http_server_api_key =>  'foobar23',
    cm_api_base_url     => 'http://www.cm.dev',
    cm_api_key          => 'fish',
    cm_application_path => '/home/cm',
    jobs_path           => '/tmp',
    jobs_retry_delay    => 300,
  }
}
