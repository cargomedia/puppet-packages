class raid {

  $raid_list = split($::raid, ',')
  include $raid_list
}
