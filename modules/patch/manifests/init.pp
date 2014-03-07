define patch(
  $path = $name,
  $content,
  $strip_level = 1
) {

  exec {"patch ${path}":
    command => "cd ${path} && echo \"${content}\" | patch --strip=${strip_level} --forward",
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    provider => shell,
  }
}
