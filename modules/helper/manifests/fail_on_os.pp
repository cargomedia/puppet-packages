define helper::fail_on_os {

  if $lsbdistid != 'Debian' {
    fail('Sorry - We only support Debian right now')
  }

  case $lsbdistcodename {
    /!^(squeeze|wheezy)$/ : { fail('Sorry - Unsupported debian version') }
  }
}
