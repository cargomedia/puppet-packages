define chromium::policy(
  $content
) {

  require 'chromium'

  file { "/etc/chromium-browser/policies/managed/${title}.json":
    ensure  => file,
    content => $content,
    group   => '0',
    owner   => '0',
    mode    => '0644',
  }

}
