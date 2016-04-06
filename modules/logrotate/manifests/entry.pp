define logrotate::entry (
  $path,
  $versions_to_keep = 14,
  $rotation_frequency = 'daily',
  $rotation_newfile = 'copytruncate',
  $rotate_ifempty = false,
  $postrotate_script = undef,

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
