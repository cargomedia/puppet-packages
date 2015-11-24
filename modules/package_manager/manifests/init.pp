class package_manager {

  case $operatingsystem {
    /^(Debian|Ubuntu)$/: {
      require 'apt'
    }
  }
}
