class irqbalance {

  require 'apt'

  file { '/etc/default/irqbalance':
    ensure  => file,
    content => template("${module_name}/default"),
    owner   => '0',
    group   => '0',
    mode    => '0755',
    notify  => Service['irqbalance'],
  }
  ->

  package { 'irqbalance':
    provider => 'apt',
  }
  ->

  service { 'irqbalance':
    enable  => true,
  }
}
