define xorg::config (
  $section,
  $key,
  $value,
  $config_name = undef,
) {

  require 'xorg'
  require 'augeas'

  $xorg_path_final = $config_name ? { undef => $xorg::config_path, default => "${xorg::config_path_dir}/${config_name}.conf" }

  augeas { "xorg::config: ${name}":
    context => "/files${xorg_path_final}",
    onlyif  => "match ${section}/${key}[. = '${value}'] size==0",
    changes => "set ${section}/${key}[last() + 1] '${value}'",
    incl    => $xorg_path_final,
    lens    => 'Xorg.lns',
    require => Class['augeas'],
  }

}
