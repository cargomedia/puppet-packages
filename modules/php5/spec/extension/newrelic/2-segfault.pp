node default {

  helper::script {'run simple php script and segfault it':
    content => template('php5/spec/newrelic/php_segfault.sh'),
    unless => false,
  }
}
