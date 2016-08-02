class postgresql::common {

  require 'apt'

  apt::source { 'postgresql':
    entries => [
      "deb http://apt.postgresql.org/pub/repos/apt/ ${::facts['lsbdistcodename']}-pgdg main",
    ],
    keys    => {
      'postgresql' => {
        key     => 'ACCC4CF8',
        key_url => 'http://www.postgresql.org/media/keys/ACCC4CF8.asc',
      }
    }
  }

}
