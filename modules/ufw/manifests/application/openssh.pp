class ufw::application::openssh($port = 22) {

  include 'ufw'

  @ufw::rule { 'OpenSSH':
    app_or_port => $port,
  }
}
