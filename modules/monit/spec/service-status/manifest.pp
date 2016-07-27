node default {

  require 'rsyslog'

  monit::service_status { 'rsyslog': }
}
