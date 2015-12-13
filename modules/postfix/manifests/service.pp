class postfix::service {

  include 'postfix'

  service { 'postfix':
    enable => true,
  }
}
