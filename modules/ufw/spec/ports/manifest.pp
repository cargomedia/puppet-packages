node default {

  class { 'coturn':
    realm => 'me',
  }

  ufw::rule { 'allow 22 - otherwise tests wont run :)':
    app_or_port => '22',
  }

  ufw::rule { 'allow 999':
    app_or_port => '999',
  }

  ufw::rule { 'allow 25/udp':
    app_or_port => '25',
    protocol    => 'udp',
  }

  ufw::rule { 'deny 80/tcp':
    app_or_port => '80',
    protocol    => 'tcp',
    allow       => false,
  }
}
