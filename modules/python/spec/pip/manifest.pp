node default {

  python::pip {'aws-ec2-assign-elastic-ip':
    ensure => '0.1.0'
  }

}
