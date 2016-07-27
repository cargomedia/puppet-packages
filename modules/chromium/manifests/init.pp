class chromium($build = undef) {

  require 'apt'

  if $build != undef {

    ensure_packages([
      'libpangocairo-1.0',
      'libnss3',
      'libcups2',
      'libgconf2-4',
      'libatk1.0-0',
      'libasound2',
      'libgtk2.0-0',
      'libxss1',
      'libxtst6'
    ], { provider => 'apt' })

    helper::script { 'install chrome browser':
        content => template("${module_name}/chromium-installer/install.sh.erb"),
        unless  => 'ls /usr/bin/chromium-browser',
    }
  } else {
    package { 'chromium-browser':
      ensure   => present,
      provider => 'apt',
    }
  }
}
