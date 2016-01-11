node default {

  class { 'ssh': }

  include 'ufw'
}
