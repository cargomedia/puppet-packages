class cm_bundler {

  require 'nodejs'

  package { 'cm-bundler':
    ensure   => '0.1.0',
    provider => 'npm',
  }
}
