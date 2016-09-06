define systemd::service(
  $content,
  $critical = true,
) {
  $unit_name = "${name}.service"
  
  systemd::unit { $unit_name:
    content  => $content,
    critical => $critical,
  }
}
