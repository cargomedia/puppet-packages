define mongodb::mongorc (
  $content,
  $path
) {

  file { $path:
    ensure   => file,
    content  => $content,
    mode     => '0755',
    group    => '0',
    owner    => '0',
  }
}
