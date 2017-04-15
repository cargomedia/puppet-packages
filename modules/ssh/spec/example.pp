# These are not going to work
# A running puppetdb (and a puppet master) is required

node keymaster {
  include 'ssh::keyserver'

  ssh::keyinstall {"foo@foobar":
    user => 'foo'
  }
}


node default {

  ssh::keyauthorized {"foo@foobar":
    user => 'root'
  }

}