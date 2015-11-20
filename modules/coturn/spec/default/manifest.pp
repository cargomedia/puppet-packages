node default {

  require 'monit'

  class{ 'coturn': }

}
