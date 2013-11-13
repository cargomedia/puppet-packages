class nginx::package::suse {
  $suse_packages = [
    'nginx-0.8', 'apache2', 'apache2-itk', 'apache2-utils', 'gd', 'libapr1',
    'libapr-util1', 'libjpeg62', 'libpng14-14', 'libxslt', 'rubygem-daemon_controller',
    'rubygem-fastthread', 'rubygem-file-tail', 'rubygem-passenger',
    'rubygem-passenger-nginx', 'rubygem-rack', 'rubygem-rake', 'rubygem-spruz',
  ]

  package {$suse_packages:
    ensure => present,
  }
}
