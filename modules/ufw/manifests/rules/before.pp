define ufw::rules::before($rules_content = undef) {

  include 'ufw'

  $rules = $rules_content ? {
    undef => template("${module_name}/${title}.rules.erb"),
    default => $rules_content,
  }

  file {
    "/etc/ufw/before.d/${title}.rules":
      ensure  => file,
      content => $rules,
      owner   => '0',
      group   => '0',
      mode    => '0644';
  }
}
