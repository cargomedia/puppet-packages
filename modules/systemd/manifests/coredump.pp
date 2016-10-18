class systemd::coredump(
  $storage = 'external',
  $compress = undef,
  $process_size_max = undef,
  $external_size_max = undef,
  $journal_size_max = undef,
  $max_use = undef,
  $keep_use = undef,
) {

  include 'sysctl::entry::core_pattern'

  file { '/etc/systemd/coredump.conf':
    ensure  => file,
    content => template("${module_name}/coredump"),
    mode    => '0644',
    owner   => '0',
    group   => '0',
  }
  ~>

  systemd::daemon_reload { "coredump-unit restart ${name}": }
}
