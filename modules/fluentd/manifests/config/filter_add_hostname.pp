define fluentd::config::filter_add_hostname (
  $pattern = '**',
  $priority = 1,
) {

  fluentd::config::filter_record_transformer{ 'hostname':
    pattern  => '**',
    record   => {
      hostname => $::fqdn,
    },
    priority => 1,
  }

}
