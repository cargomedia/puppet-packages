define xorg::config (
  $section,
  $key,
  $value,
  $config_path = undef,
) {

  include 'augeas'
  include 'xorg::common'

  $xorg_path_final = $config_path ? { undef => $xorg::common::config_path, default => $config_path }

  augeas { "section-file-${name}":
    context => "/files${xorg_path_final}",
    onlyif  => "match ${section}/${key}[. = '${value}'] size==0",
    changes => "set ${section}/${key}[last() + 1] '${value}'",
    incl    => $xorg_path_final,
    lens    => 'Xorg.lns',
    require => Class['augeas'],
  }

}
