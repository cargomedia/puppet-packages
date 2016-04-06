node default {

  apache2::vhost { 'foo':
    content => '
Listen 1234
<VirtualHost *:1234>
  DocumentRoot /tmp
</VirtualHost>
',
  }

}
