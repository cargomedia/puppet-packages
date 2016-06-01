class jenkins::plugin::ghprb(
  $access_token,
  $admin_list = []
) {

  require 'jenkins::plugin::git'
  require 'jenkins::plugin::github'
  require 'jenkins::plugin::github_api'

  $config_puppet = '/var/lib/jenkins/org.jenkinsci.plugins.ghprb.GhprbTrigger-puppet.xml'
  $config_jenkins = '/var/lib/jenkins/org.jenkinsci.plugins.ghprb.GhprbTrigger.xml'

  file { $config_puppet:
    ensure    => 'present',
    content   => template("${module_name}/plugin/ghprb.xml"),
    owner     => 'jenkins',
    group     => 'nogroup',
    mode      => '0644',
  }
  ->

  # Compare beginning of config file (first $L lines), and copy if they differ
  exec { $config_jenkins:
    command   => "cp ${config_puppet} ${config_jenkins}",
    logoutput => true,
    unless    => "bash -c 'L=$(($(wc -l < ${config_puppet}) - 1)) && diff <(head -n \${L} ${config_puppet}) <(head -n \${L} ${config_jenkins})'",
    provider  => shell,
    path      => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    user      => 'jenkins',
    group     => 'nogroup',
  }
  ->

  jenkins::plugin { 'ghprb':
    version => '1.32.2',
  }

}
