define apt::key (
  $ensure = present,
  $key,
  $key_url = undef,
  $key_server = undef,
) {
  require 'apt'

  $condition = "apt-key list | grep -E '^pub\s+\w+/${key}\s+'"

  case $ensure {
    present: {
      if !$key_server and !$key_url {
        fail "[apt::key] key_url or key_server is needed for ensure => present"
      }
      if ($key_url) {
        exec { "Add deb signature key for $name":
          command   => "wget -q '${key_url}' -O- | apt-key add -",
          path      => ['/bin','/usr/bin'],
          unless    => $condition,
          logoutput => 'on_failure',
          notify    => Exec['apt_update']
        }
      }
      if ($key_server) {
        exec { "Add deb signature key for $name":
          command   => "apt-key adv --keyserver ${key_server} --recv-keys ${key}",
          path      => ['/bin','/usr/bin'],
          unless    => $condition,
          logoutput => 'on_failure',
          notify    => Exec['apt_update']
        }
      }
    }

    absent: {
      exec { "Remove deb signature key for $name":
        command   => "apt-key del '${key}'",
        path      => ['/bin','/usr/bin'],
        onlyif    => $condition,
        logoutput => 'on_failure',
        notify    => Exec['apt_update']
      }
    }

    default: {
        fail "Invalid 'ensure' value '${ensure}' for apt::key (Must be present|absent)"
    }
  }
}
