node default {

  class { 'gearman::server':
    jobretries => 255,
  }

}
