define apt::key (
  $ensure = present,
  $key,
  $key_url = undef,
)
{
  require 'apt'

  $condition = "apt-key list | grep -E '^pub\s+\w+/${key}\s+'"

  case $ensure {
    present: {
      if !($key_url) {
        fail "[apt::key] key_url is needed for ensure => present"
      }
      exec { "Add deb signature key for $name":
        command   => "wget -q '${key_url}' -O- | apt-key add -",
        path      => ['/bin','/usr/bin'],
        unless    => $condition,
        logoutput => 'on_failure',
      }
    }

    absent: {
      exec { "Remove deb signature key for $name":
        command   => "apt-key del '${key}'",
        path      => ['/bin','/usr/bin'],
        onlyif    => $condition,
        logoutput => 'on_failure',
      }
    }

    default: {
        fail "Invalid 'ensure' value '${ensure}' for apt::key (Must be present|absent)"
    }
  }
}
