# Keymaster host:
# Create key storage; create, regenerate, and remove key pairs
class ssh::sshkeys::keymaster {
  include sshkeys::var
  file { $sshkeys::var::keymaster_storage:
    ensure => directory,
    owner  => puppet,
    group  => puppet,
    mode   => 644,
  }
  # Realize all virtual master keys
  Ssh::Sshkeys::Setup_key_master <| |>
}
