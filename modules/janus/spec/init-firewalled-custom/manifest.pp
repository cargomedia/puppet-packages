node default {

  class { 'janus':
    ufw_app_profile => '22,44,25000:30000/tcp|25000:30000/udp'
  }

  include 'ufw'
}
