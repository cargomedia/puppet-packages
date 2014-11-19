node default {

  class {'puppet::agent':
    nice_value => 19,
  }

}
