node default {

  class {'cacti::agent::ssh':
    userName  => 'cacti',
    userId    => 3001,
    groupName => 'cacti',
    groupId   => 3001
  }
}
