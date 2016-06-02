class jenkins::plugin::matrix_auth {

  jenkins::plugin { 'matrix-auth':
    version => '1.3.2',
  }

}
