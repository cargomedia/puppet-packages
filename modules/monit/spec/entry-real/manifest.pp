node default {

  class {'puppet::agent':}

  class {'monit':}
}
