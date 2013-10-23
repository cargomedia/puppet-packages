node default {

  class {'cacti::agent':
    userName  => 'cacti',
    userId    => 3001,
    groupName => 'cacti',
    groupId   => 3001
  }
}
