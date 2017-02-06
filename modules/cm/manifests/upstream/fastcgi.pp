define cm::upstream::fastcgi($members) {

  include 'nginx'

  $upstream_members = suffix($members, ' max_fails=3 fail_timeout=3')

  nginx::resource::upstream { $name:
    members             => $upstream_members,
  }

}
