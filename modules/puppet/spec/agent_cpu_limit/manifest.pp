node default {

  class {'puppet::agent':
    cpu_limit => 50,
  }

}
