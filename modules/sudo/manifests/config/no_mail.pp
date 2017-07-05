class sudo::config::no_mail {

  $mail_events = [
    'mail_always',
    'mail_badpass',
    'mail_no_user',
    'mail_no_host',
    'mail_no_perms',
  ]

  @sudo::config { 'no-mail':
    content => inline_template('<% @mail_events.each do |i| -%><%= "Defaults !#{i}\n" %><% end -%>'),
  }

}
