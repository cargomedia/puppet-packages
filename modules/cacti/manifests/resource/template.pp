class cacti::resource::template (
  $content      = undef,
  $resourceDir  = $cacti::params::resourceDir,
  $templateDir  = $cacti::params::templateDir,
) inherits cacti::params {

  file {$templateDir:
    ensure => directory,
  }

  file {"${templateDir}/${name}":
    ensure  => file,
    content => $content,
  }
}