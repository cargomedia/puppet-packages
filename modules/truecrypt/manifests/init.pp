class truecrypt(
  $version = '7.2'
) {

  require 'build'

  package {['libfuse-dev', 'nasm', 'libpkcs11-helper1-dev', 'libwxbase2.8-dev', 'pkg-config']:}

  helper::script {'install truecrypt':
    content => template("${module_name}/install.sh"),
    unless => "truecrypt --version | grep -e 'TrueCrypt ${version}$'",
    timeout => 900,
  }

}
