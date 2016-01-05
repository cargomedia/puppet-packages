class iptables(
  $stateful = true,
) {

  require 'apt'

  package { 'iptables':
    ensure   => present,
    provider => 'apt',
  }

  if ($stateful) {
    iptables::entry { 'Stateful firewall init':
      chain => 'INPUT',
      rule  => '-m state --state RELATED,ESTABLISHED -j ACCEPT',
    }
  }
}
