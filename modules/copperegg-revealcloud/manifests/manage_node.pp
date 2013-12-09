class copperegg-revealcloud::manage_node {

  exec {'enable revealcloud node':
    command => "/etc/init.d/revealcloud stop && ${dir}/revealcloud -x -a ${api_host} -k ${api_key} -E && /etc/init.d/revealcloud start",
    refreshonly => true,
    user => 'revealcloud',
    group => 'revealcloud',
    require => File['/etc/init.d/revealcloud'],
    before => Service['revealcloud'],
  }

  exec {'disable revealcloud node':
    command => "/etc/init.d/revealcloud stop && ${dir}/revealcloud -x -a ${api_host} -k ${api_key} -R",
    refreshonly => true,
    user => 'revealcloud',
    group => 'revealcloud',
    require => File['/etc/init.d/revealcloud'],
  }
}
