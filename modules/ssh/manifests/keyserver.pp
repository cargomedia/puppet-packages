class ssh::keyserver {
  include ssh::sshkeys::keymaster
  Ssh::Sshkeys::Create_key <<| |>>
}
