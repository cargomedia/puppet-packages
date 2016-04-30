define puppet::gem {

  include 'puppet::common'

  package { "${title} (puppet)":
    ensure   => present,
    name  => $title,
    provider => puppet_gem,
    require  => Package['puppet-agent'],
  }

}
