node default {

  host { 'foo.test.bar':
    ip           => '127.0.0.1',
  }

  cm::upstream::fastcgi { 'fastcgi-farm':
    members => ['192.168.1.1:443','192.168.1.2'],
  }

  cm::upstream::fastcgi { 'fastcgi-upstream':
    members => ['foo.test.bar:8080'],
  }

}
