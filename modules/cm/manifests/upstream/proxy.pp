define cm::upstream::proxy($members) {

  include 'nginx'

  $upstream_members = suffix($members, ' max_fails=0 fail_timeout=1')

  nginx::resource::upstream { $name:
    members             => $upstream_members,
    upstream_cfg_append => [
      'keepalive 100;',
    ],
  }
}
