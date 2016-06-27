class locale($lang = 'en_US.UTF-8') {

  if ($::facts['lsbdistid'] == 'Debian') {
    exec { "Uncomment ${lang} if needed":
      provider => shell,
      command  => "sed -i '/${lang}/s/^# //g' /etc/locale.gen",
      unless   => "grep -qE '^${lang}' /etc/locale.gen",
      path     => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    }
  }

  exec { "Generate locale for ${lang}":
    provider    => shell,
    command     => "locale-gen ${lang}",
    unless      => "grep -qE '^LANG=${lang}$' /etc/default/locale",
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }
  ~>

  exec { "Update locale for ${lang}":
    provider    => shell,
    command     => "update-locale LANG='${lang}'",
    refreshonly => true,
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }
}
