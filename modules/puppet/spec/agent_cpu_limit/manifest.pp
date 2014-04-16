node default {

  class {'puppet::agent':
    cpu_shares => 50,
  }

}
