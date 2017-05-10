class fluentd::config::filter_add_hostname (
  $pattern = '**',
  $priority = 50,
) {

  fluentd::config::filter_record_modifier{ 'hostname':
    pattern  => '**',
    record   => {
      hostname => $::facts['fqdn'],
    },
    priority => 50,
  }

}
