node default {

  class { 'apt::source::cargomedia': }
  class { 'apt::source::cargomedia_private': }
}
