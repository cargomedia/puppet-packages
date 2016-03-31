define logrotate::entry (
  $path,
  $versions_to_keep = 12,
  $rotation_frequency = 'daily',
  $rotation_newfile = 'create',
  $additional_config = undef,
) {

  require 'logrotate'

  file { "/etc/logrotate.d/${title}":
    ensure      => file,
    content     => template("${module_name}/logrotate.entry.erb"),
    owner       => '0',
    group       => '0',
    mode        => '0644',
  }
}
