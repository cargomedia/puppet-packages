node default {

  chromium::extension{ 'lgtm':
    id => 'oeacdmeoegfagkmiecjjikpfgebmalof',
  }
  ->

  xpra::display { '99':
  }
  ->

  user { 'bob':
    ensure     => present,
    managehome => true,
    home       => '/home/bob',
  }
  ->

  exec { 'start chromium':
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    provider    => shell,
    user        => 'bob',
    environment => ['DISPLAY=:99', 'HOME=/home/bob'],
    command     => 'chromium-browser &',
  }

}
