node default {

  require 'monit'

  class{ 'janus':
    use_src => true,
  }

}
