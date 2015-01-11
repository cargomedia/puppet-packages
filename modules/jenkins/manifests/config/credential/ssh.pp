define jenkins::config::credential::ssh(
  $id = $title,
  $username,
  $privateKey
) {

  include 'jenkins::config::credentials'

  file {"/var/lib/jenkins/credentials.d/20-ssh-${id}.xml":
    ensure    => 'present',
    content   => template("${module_name}/config/credentials/20-ssh.xml"),
    owner     => 'jenkins',
    group     => 'nogroup',
    mode      => '0644',
    notify    => Exec['/var/lib/jenkins/credentials.xml'],
  }

}
