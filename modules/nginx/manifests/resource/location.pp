define nginx::resource::location(
  $ensure               = present,
  $vhost                = undef,
  $www_root             = undef,
  $index_files          = ['index.html', 'index.htm', 'index.php'],
  $proxy                = undef,
  $proxy_read_timeout   = $nginx::params::nx_proxy_read_timeout,
  $ssl                  = false,
  $ssl_only             = false,
  $location_alias       = undef,
  $option               = undef,
  $stub_status          = undef,
  $location_cfg_prepend = undef,
  $location_cfg_append  = undef,
  $try_files            = undef,
  $location
) {

  include 'nginx::config'
  include 'nginx::params'

  File {
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    notify => Class['nginx::service'],
  }

## Shared Variables
  $ensure_real = $ensure ? {
    'absent' => absent,
    default  => file,
  }

# Use proxy template if $proxy is defined, otherwise use directory template.
  if ($proxy != undef) {
    $content_real = template("${module_name}/vhost/vhost_location_proxy.erb")
  } elsif ($location_alias != undef) {
    $content_real = template("${module_name}/vhost/vhost_location_alias.erb")
  } elsif ($stub_status != undef) {
    $content_real = template("${module_name}/vhost/vhost_location_stub_status.erb")
  } elsif ($www_root != undef) {
    $content_real = template("${module_name}/vhost/vhost_location_directory.erb")
  } else {
    $content_real = template("${module_name}/vhost/vhost_location.erb")
  }

## Check for various error conditions
  if ($vhost == undef) {
    fail('Cannot create a location reference without attaching to a virtual host')
  }
  if (($www_root != undef) and ($proxy != undef)) {
    fail('Cannot define both directory and proxy in a virtual host')
  }

## Create stubs for vHost File Fragment Pattern
  if ($ssl_only != true) {
    file { "${nginx::config::nx_temp_dir}/nginx.d/${vhost}-500-${name}":
      ensure  => $ensure_real,
      content => $content_real,
    }
  }

## Only create SSL Specific locations if $ssl is true.
  if ($ssl == true) {
    file { "${nginx::config::nx_temp_dir}/nginx.d/${vhost}-800-${name}-ssl":
      ensure  => $ensure_real,
      content => $content_real,
    }
  }
}
