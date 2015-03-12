node default {

  class { 'puppet::master':
    puppetdb => true,
  }
}
