class ssh::keyserver {
  include sshkeys::keymaster
  Sshkeys::Create_key <<| |>>
}