class polipo::service {

  require 'polipo'

  service { 'polipo':
    enable => true,
  }
}
