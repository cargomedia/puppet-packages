class raid {

  $raid_list = split($::raid, ',')
  include $raid_list

  unless size($raid_list) > 0 {
    warning('Should not use `raid` class if no raid hardware present')
  }
}
