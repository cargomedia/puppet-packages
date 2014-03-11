define patch(
  $pwd = $name,
  $content,
  $strip_level = 1
) {

  $patch_file_name = md5($content)
  $patch_file = "/tmp/${patch_file_name}"

  file {$patch_file:
    content => $content,
    group => '0',
    owner => '0',
    mode => '0644',
  }
  ->

  exec {"patch ${pwd}":
    command => "cd ${pwd} && patch --strip=${strip_level} --forward < ${patch_file}",
    returns => [ '0', '1' ],
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    provider => shell,
  }

}
