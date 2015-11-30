define ruby::gem (
  $ensure = present,
  $source = undef,
) {

  require 'ruby'

  package { $name:
    ensure   => $ensure,
    provider => gem,
    source   => $source,
  }
}
