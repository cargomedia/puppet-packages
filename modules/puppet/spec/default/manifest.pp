node default {

  puppet::module {'puppetlabs-stdlib':
    update => true,
  }
}
