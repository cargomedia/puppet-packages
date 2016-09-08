define systemd::service(
  $content,
  $critical = true,
) {
  $unit_name = "${name}.service"

  systemd::unit { $unit_name:
    service_name => $name,
    content      => $content,
    critical     => $critical,
  }
}
