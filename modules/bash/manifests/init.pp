class bash ($prompt = '\u@$(hostname -f):\w$ ') {

  $escapedPrompt = shellquote($prompt)

  file {'/etc/bash.bashrc':
    ensure => file,
    content => template("${module_name}/bashrc"),
    owner => '0',
    group => '0',
    mode => '0644',
  }
}
