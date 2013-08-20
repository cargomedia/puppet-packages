define apt::key (
  $ensure = present,
  $key,
  $key_url = undef,
)
{

  case $ensure {
    present: {
      if !($key_url) {
        fail "[apt::key] key_url is needed for ensure => present"
      }

      apt::key_add { "$name":
        key => $key,
        key_url => $key_url
      }

    }

    absent: {
      exec { "Remove deb signature key":
        command   => "apt-key del '${key}'",
        path      => '/bin:/usr/bin',
        onlyif    => "apt-key list | grep '${key}'",
        logoutput => 'on_failure',
      }
    }

    default: {
        fail "Invalid 'ensure' value '${ensure}' for apt::key (Must be present|absent)"
    }
  }
}
