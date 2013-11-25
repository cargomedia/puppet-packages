node default {

  class {'cacti::agent::ssh':
    userId    => 3001,
    groupId   => 3001,
  }
}
