class iptables(
  $stateful = true,
  $allow_useful_ICMP = false,
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

  if ($allow_useful_ICMP) {
    iptables::entry { 'Allow icmp type 3':
      chain => 'INPUT',
      rule  => '-p icmp  -m icmp  --icmp-type 3  -m state --state NEW  -j ACCEPT',
    }
    ->

    iptables::entry { 'Allow icmp type 0/0':
      chain => 'INPUT',
      rule  => '-p icmp  -m icmp  --icmp-type 0/0  -m state --state NEW  -j ACCEPT',
    }
    ->

    iptables::entry { 'Allow icmp type 8/0':
      chain => 'INPUT',
      rule  => '-p icmp  -m icmp  --icmp-type 8/0  -m state --state NEW  -j ACCEPT',
    }
    ->

    iptables::entry { 'Allow icmp type 11/0':
      chain => 'INPUT',
      rule  => '-p icmp  -m icmp  --icmp-type 11/0  -m state --state NEW  -j ACCEPT',
    }
    ->

    iptables::entry { 'Allow icmp type 11/1':
      chain => 'INPUT',
      rule  => '-p icmp  -m icmp  --icmp-type 11/1  -m state --state NEW  -j ACCEPT',
    }
  }
}
