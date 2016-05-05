define xorg::config (
  $section,
  $key,
  $value,
  $config_name = undef,
  $extra_quoted_value = false,
) {

  require 'xorg'
  require 'augeas'

  $config_path = $config_name ? { undef => $xorg::config_path, default => "${xorg::config_path_dir}/${config_name}.conf" }

  $val = $extra_quoted_value ? { false => $value, true => "\"${value}\"" }

  augeas { "xorg::config: ${name}":
    context => "/files${config_path}",
    onlyif  => "match ${section}/${key}[. = '${value}'] size==0",
    changes => "set ${section}/${key}[last() + 1] '${val}'",
    incl    => $config_path,
    lens    => 'Xorg.lns',
    require => Class['augeas'],
  }

}
