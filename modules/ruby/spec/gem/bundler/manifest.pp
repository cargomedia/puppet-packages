node default {

  class { 'ruby::gem::bundler':
    version => '1.6.4',
  }
}
