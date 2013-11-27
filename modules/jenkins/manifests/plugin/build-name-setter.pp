class jenkins::plugin::build-name-setter {

  require 'jenkins::plugin::token-macro'

  jenkins::plugin {'build-name-setter':
    version => '1.3',
  }

}
