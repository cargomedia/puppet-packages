node default {

  require 'rsyslog'

  monit::entry::status { 'rsyslog': }

}
