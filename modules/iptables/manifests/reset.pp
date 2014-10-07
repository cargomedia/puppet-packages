define iptables::reset() {

  $F = 'flush'
  $D = 'delete-chain'

  $reset_tables = {
    'chains_all_flush' => {
      command => $F,
    },
    'chains_all_delete' => {
      command => $D,
    },
    'filter_chains_all_flush' => {
      command => $F,
      table => 'filter',
    },
    'filter_chains_all_delete' => {
      command => $D,
      table => 'filter',
    },
    'nat_chains_all_flush' => {
      command => $F,
      table => 'nat',
    },
    'nat_chains_all_delete' => {
      command => $D,
      table => 'nat',
    },
    'mangle_chains_all_flush' => {
      command => $F,
      table => 'mangle',
    },
    'mangle_chains_all_delete' => {
      command => $D,
      table => 'mangle',
    },
  }

  create_resources('iptables::entry', $reset_tables)

}
