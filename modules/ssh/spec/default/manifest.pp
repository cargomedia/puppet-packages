node default {

  include 'ufw'

  class { 'ssh': }

  ssh::pair { 'my-pair':
    id   => 'my-id',
    user => 'root',
    fqdn => $::facts['fqdn'],
  }

}
