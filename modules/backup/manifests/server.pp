class backup::server(
  $id
) {

  require 'rdiff-backup'

  class {'backup::ssh::grant':
    id => $id,
  }

}
