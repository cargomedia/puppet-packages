# These are not going to work
# A running puppetdb (and a puppet master) is required

node default {

  ssh::keycreate{"foo@foobar":  }

  ssh::keyauthorized{"foo@foobar":
    user => 'root'
  }

}