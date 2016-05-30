node default {

  host { 'www.example.com':
    ip => '127.0.0.1',
  }

  package { ['socat']: }

  exec { 'Start listening on with https':
    command => 'socat -v openssl-listen:1337,fork,reuseaddr,cert=/etc/nginx/ssl/www.example.com.pem,key=/etc/nginx/ssl/www.example.com.key,verify=0 echo 2>/tmp/https.log &',
    unless  => 'pgrep socat',
    path    => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }

  cm::reverse_proxy { 'www.example.com':
    ssl_cert         => template('cm/spec/spec-ssl.pem'),
    ssl_key          => template('cm/spec/spec-ssl.key'),
    upstream_options => {
      members => ['localhost:1337'],
      ssl => true,
    }
  }
}
