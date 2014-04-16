node default {

  include 'monit'

  class {'mongodb::role::standalone': }

}
