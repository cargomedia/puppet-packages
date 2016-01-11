class ufw::application::openssh($port = 22) {

  include 'ufw'

  ufw::application { 'OpenSSH':
    app_ports => "${port}/tcp",
  }
}
