class cacti::resource::site::script (
  $content    = undef,
  $resourceDir  = $cacti::params::resourceDir,
  $scriptDir  = $cacti::params::scriptDir
) inherits cacti::params {

  file {$scriptDir:
    ensure => directory,
  }

  file {"${scriptDir}/${name}":
    ensure  => file,
    content => $content,
  }
}