node default {

  host { 'foo.test':
    ip           => '127.0.0.1',
  }

  cm::upstream::proxy { 'reverse-proxy-backend':
    members => ['localhost:443','localhost:444'],
  }

  cm::upstream::proxy { 'reverse-proxy-another-one':
    members => ['foo.test:8080'],
  }

}
