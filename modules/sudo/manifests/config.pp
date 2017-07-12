define sudo::config (
  $content
) {

  $config_content = inline_template('<%= @content + (@content[-1,1] != "\n" ? "\n" : "") %>')

  validate_cmd($config_content, '/usr/sbin/visudo -c -f', "visudo failed to validate sudoers content:\n{content}${config_content}{/content}")

  file { "/etc/sudoers.d/${title}":
    ensure  => file,
    owner   => '0',
    group   => '0',
    mode    => '0440',
    content => $config_content,
  }
}
