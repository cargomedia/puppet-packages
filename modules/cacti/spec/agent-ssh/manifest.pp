node default {

  class {'cacti::agent::ssh':
    user_id   => 3001,
    group_id  => 3001,
  }

}
