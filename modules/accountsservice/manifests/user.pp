define accountsservice::user(
  $user = $title,
  $xsession,
) {

  require 'accountsservice'

  if (defined(User[$user])) {
    User[$user] -> Accountsservice::User[$title]
  }

  $connection_name = 'org.freedesktop.Accounts'
  $object_path = "/org/freedesktop/Accounts/User$(id -u ${user})"

  exec { "set default xsession for user ${user}":
    path     => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    provider => shell,
    command  => "dbus-send --system --type=method_call --print-reply --dest=${$connection_name} ${object_path} org.freedesktop.Accounts.User.SetXSession string:\"${xsession}\"",
    unless   => "dbus-send --system --type=method_call --print-reply --dest=${$connection_name} ${object_path} org.freedesktop.DBus.Properties.Get string:\"org.freedesktop.Accounts.User\" string:\"XSession\" | grep 'string \"${xsession}\"'",
  }

}
