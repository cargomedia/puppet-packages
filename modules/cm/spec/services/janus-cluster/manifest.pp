node default {

  cm::services::janus { 'standalone1':
    hostname                         => 'foohost1',
    http_server_api_key              => 'janus-fish',
    http_server_port                 => 8100,
    websocket_server_port            => 8110,

    ssl_cert                         => template("${module_name}/spec/spec-ssl.pem"),
    ssl_key                          => template("${module_name}/spec/spec-ssl.key"),

    cm_application_path              => '/home/cm',
    cm_api_base_url                  => 'http://www.cm-api.dev',
    cm_api_key                       => 'cm-fish',

    rtpbroadcast_minport             => 8400,
    rtpbroadcast_maxport             => 9000,

    janus_http_port                  => 8300,
    janus_websockets_port            => 8310,
    cm_janus_websocket_port          => 8210,
    transport_http_secure_port       => 8301,
    transport_http_admin_port        => 8302,
    transport_http_admin_secure_port => 8303,
  }

  cm::services::janus { 'standalone2':
    hostname                         => 'foohost2',
    http_server_api_key              => 'janus-fish',
    http_server_port                 => 18100,
    websocket_server_port            => 18110,

    ssl_cert                         => template("${module_name}/spec/spec-ssl.pem"),
    ssl_key                          => template("${module_name}/spec/spec-ssl.key"),

    cm_application_path              => '/home/cm',
    cm_api_base_url                  => 'http://www.cm-api.dev',
    cm_api_key                       => 'cm-fish',

    rtpbroadcast_minport             => 18400,
    rtpbroadcast_maxport             => 19000,

    janus_http_port                  => 18300,
    janus_websockets_port            => 18310,
    cm_janus_websocket_port          => 18210,
    transport_http_secure_port       => 18301,
    transport_http_admin_port        => 18302,
    transport_http_admin_secure_port => 18303,
  }

  cm::services::janus { 'standalone3':
    hostname                         => 'foohost3',
    http_server_api_key              => 'janus-fish',
    http_server_port                 => 28100,
    websocket_server_port            => 28110,

    ssl_cert                         => template("${module_name}/spec/spec-ssl.pem"),
    ssl_key                          => template("${module_name}/spec/spec-ssl.key"),

    cm_application_path              => '/home/cm',
    cm_api_base_url                  => 'http://www.cm-api.dev',
    cm_api_key                       => 'cm-fish',

    rtpbroadcast_minport             => 28400,
    rtpbroadcast_maxport             => 29000,

    janus_http_port                  => 28300,
    janus_websockets_port            => 28310,
    cm_janus_websocket_port          => 28210,
    transport_http_secure_port       => 28301,
    transport_http_admin_port        => 28302,
    transport_http_admin_secure_port => 28303,
  }
}
