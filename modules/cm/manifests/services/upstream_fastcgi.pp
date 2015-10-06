class cm::services::upstream_fastcgi(
  $upstream_name = 'fastcgi-backend',
  $members = ['localhost:9000']
) {

  include 'cm::services::webserver'

  $upstream_members = suffix($members, ' max_fails=3 fail_timeout=3')

  nginx::resource::upstream { $upstream_name:
    ensure              => present,
    members             => $upstream_members,
    upstream_cfg_append => [
      'keepalive 400;',
    ],
  }

}
