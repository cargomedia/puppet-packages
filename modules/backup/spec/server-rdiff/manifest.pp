node default {

  class {'backup::server':
    type => 'rdiff',
    restoreList => {
      'root@db' => {
        'host' => 'db@10.10.10.10',
        'source' => 'db',
        'destination' => '/var/lib/mysql',
        'key' => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQC67Jhm1ywwgPAGmP1W02W5B24bD1RkgFSprfTLs100wSuJ9N8oDvSCrgm6i6r+Ukcf5ffxQOjtPNulrB+NCYk3CIsIEaqBNRcLDwEQl1VWoQpw8xgmk4KdVvdkidVFkbzbVN6v/ctAkFHXXyAmy9eP8Nq53wkZ2BvuAYKImmrziExvzwG2x7UbBlPf41LF0GC0oqQZzNiOw6RJqzm5RDw6ApMMCbrjphkHNOFJoxTdbMtEQFUWlRJKgIAQ6OZWRWz2aq3tM+TEN2XBP/WytYUilvTr1bAHv6lNfr3T7xBIkdCP97yhiOJPbnqqmqX7vUkSPZJ1Bui0XGXh4jbZIRS3',
      },
      'root@storage' => {
        'host' => 'storage@10.10.10.11',
        'source' => 'shared',
        'destination' => '/raid/shared',
        'key' => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQC3gw+uneiYw+uoe32GIjJCRntFkXYMf3Uzf/v8lfZ0k+7B5++ixzJe+ML/1Os7NSQS3URDhffB17jY6EpW0zqSGx3h2jz8KoOHUQPaESAoXzT8mOLE0HrWiTe2zxzfGbOEL5AUIuLxXHcM6zMvZjagimnKAHdbwd7UQi3+Fn9NaoA1Gafp7Rc6Z0Yd98X/whmbG8Y3fHHiCQ0/B0PYs14bnYOK+NMK8qkI81uJas8HxbW1uDLw4IxmOYa1Ub0DDItcPWKYrGCaCfCRhLXi8pvAIZOySS5OZzL/eTlUDBABQNxSnL8VBVz2G4Se9lEyX57IjjhG+LBX0U6sfrHR5ToP'
      }
    }
  }

}