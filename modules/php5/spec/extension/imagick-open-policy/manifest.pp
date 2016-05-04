node default {

  class { 'php5::extension::imagick':
    policy_config => false,
  }
}
