class puppet::master::server(
  $engine = 'webrick'
) {

  if $engine == 'passenger' {
    include 'puppet::master::server_engine::passenger'
  } else {
    include 'puppet::master::server_engine::webrick'
  }

}
