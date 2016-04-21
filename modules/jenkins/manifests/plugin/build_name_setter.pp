class jenkins::plugin::build_name_setter {

  require 'jenkins::plugin::token_macro'

  jenkins::plugin { 'build-name-setter':
    version => '1.6.3',
  }

}
