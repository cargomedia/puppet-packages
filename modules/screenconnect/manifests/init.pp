class screenconnect(
  $machine_name = $::clientcert,
  $account,
  $server,
  $key
) {

  require 'java::jre'

  $port = 443
  $deb_url = "https://${account}.screenconnect.com/Bin/ScreenConnect.ClientSetup.deb?h=${server}&p=${port}&k=${key}&e=Access&y=Guest&t=${machine_name}"

  helper::script { 'install screenconnect':
    content => template("${module_name}/install.sh.erb"),
    unless  => 'dpkg -l screenconnect-*',
    require => Class['apt::update'],
  }

}
