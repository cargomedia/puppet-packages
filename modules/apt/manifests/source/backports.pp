class apt::source::backports {

  apt::source { 'backports':
    entries => [
      "deb http://ftp.debian.org/debian ${::facts['lsbdistcodename']}-backports main",
    ]
  }
}

