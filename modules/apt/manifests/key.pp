define apt::key (
  $ensure = present,
  $key,
  $key_url = undef,
  $key_server = undef,
  $key_content = undef
) {
  require 'apt'

  $condition = "apt-key list | grep -E '^pub\\s+\\w+/${key}\\s+'"

  case $ensure {
    present: {
      if !$key_server and !$key_url and !$key_content {
        fail '[apt::key] key_url or key_server or key_content is needed for ensure => present'
      }
      if ($key_url) {
        exec { "Add deb signature key for ${name}":
          command   => "curl --silent '${key_url}' | sudo apt-key add -",
          path      => ['/bin','/usr/bin'],
          unless    => $condition,
          logoutput => 'on_failure',
          notify    => Exec['apt_update']
        }
      }
      if ($key_server) {
        exec { "Add deb signature key for ${name}":
          command   => "apt-key adv --keyserver ${key_server} --recv-keys ${key}",
          path      => ['/bin','/usr/bin'],
          unless    => $condition,
          logoutput => 'on_failure',
          notify    => Exec['apt_update']
        }
      }
      if ($key_content) {
        file { "/etc/apt/trusted.gpg.d/${name}":
          ensure  => file,
          content => $key_content,
          owner   => 0,
          group   => 0,
          mode    => '0644',
          notify  => Exec['apt_update'],
        }
      }
    }

    absent: {
      exec { "Remove deb signature key for ${name}":
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
