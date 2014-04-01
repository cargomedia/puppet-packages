node default {

  class {'monit':}
  class {'monit::entry::system':}
}
