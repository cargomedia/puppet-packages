node default {

  class { 'cm::services':
    ssl_cert            => template('cm/spec/spec-ssl.pem'),
    ssl_key             => template('cm/spec/spec-ssl.key'),
  }
}
