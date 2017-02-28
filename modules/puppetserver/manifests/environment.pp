define puppetserver::environment (
  $manifest       = undef,
  $puppetfile     = undef,
  $hiera_data_dir = undef,
) {

  include 'puppetserver'

  $directory = "/etc/puppetlabs/code/environments/${name}"
  $data_directory = $hiera_data_dir ? {
    undef   => "${directory}/hieradata",
    default => $hiera_data_dir,
  }

  file {
    [$directory, "${directory}/manifests", "${directory}/modules", $data_directory]:
      ensure => directory,
      group  => '0',
      owner  => '0',
      mode   => '0644';

    "${directory}/hiera.yaml":
      ensure  => file,
      content => template("${module_name}/puppet/hiera.yaml.erb"),
      group   => '0',
      owner   => '0',
      mode    => '0644',
      before  => Package['puppetserver'],
      notify  => Service['puppetserver'];

    "${data_directory}/common.yaml":
      ensure  => file,
      content => template("${module_name}/puppet/common.yaml"),
      group   => '0',
      owner   => '0',
      mode    => '0644',
      before  => Package['puppetserver'],
      notify  => Service['puppetserver'];
  }

  if ($manifest) {
    file { "${directory}/manifests/site.pp":
      ensure  => file,
      content => $manifest,
      group   => '0',
      owner   => '0',
      mode    => '0644',
      before  => Package['puppetserver'],
      notify  => Service['puppetserver'],
    }
  }

  if ($puppetfile) {
    puppet::puppetfile { $directory:
      content => $puppetfile,
      require => File["${directory}/modules"],
      before  => Package['puppetserver'],
      notify  => Service['puppetserver'],
    }
  }

}
