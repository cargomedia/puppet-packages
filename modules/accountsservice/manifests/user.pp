define accountsservice::user(
  $user = $title,
  $xsession,
) {

  require 'accountsservice'

  if (defined(User[$user])) {
    User[$user] -> Accountsservice::User[$title]
  }

  # Find user before calling "SetXSession", to make sure it is created
  $find_user = "dbus-send --system --type=method_call --print-reply --dest=org.freedesktop.Accounts /org/freedesktop/Accounts org.freedesktop.Accounts.FindUserByName string:\"${user}\""
  exec { "find user ${user}":
    path      => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    command   => $find_user,
    unless    => $find_user,
  }

  $xsession_set = "dbus-send --system --type=method_call --print-reply --dest=org.freedesktop.Accounts /org/freedesktop/Accounts/User$(id -u ${user}) org.freedesktop.Accounts.User.SetXSession string:\"${xsession}\""
  $xsession_get = "dbus-send --system --type=method_call --print-reply --dest=org.freedesktop.Accounts /org/freedesktop/Accounts/User$(id -u ${user}) org.freedesktop.DBus.Properties.Get string:\"org.freedesktop.Accounts.User\" string:\"XSession\""
  exec { "set default xsession for user ${user}":
    path     => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    provider => shell,
    command  => $xsession_set,
    unless   => "${xsession_get} | grep 'string \"${xsession}\"'",
    require  => Exec["find user ${user}"],
  }

}
