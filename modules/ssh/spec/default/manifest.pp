node default {

  class {'ssh':
    permit_root_login => 'without-password',
  }
}
