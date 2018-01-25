<?php

$infoOpcode = @apc_cache_info('opcode', true);
$infoUser = @apc_cache_info('user', true);
$infoAlloc = @apc_sma_info(true);

// see https://github.com/krakjoe/apcu/blob/master/apc.php#L754
$total_mem_size = (int) $infoAlloc['num_seg'] * (int) $infoAlloc['seg_size'];
$avail_mem_size = (int) $infoAlloc['avail_mem'];
$used_mem_size = $total_mem_size - $avail_mem_size;

$prefix = 'php';
$metrics = [
    'apc_opcode_mem_size_bytes' => (int) $infoOpcode['mem_size'],
    'apc_user_mem_size_bytes'   => (int) $infoUser['mem_size'],
    'apc_total_mem_size_bytes'  => $total_mem_size,
    'apc_avail_mem_size_bytes'  => $avail_mem_size,
    'apc_used_mem_size_bytes'   => $used_mem_size,
];

foreach ($metrics as $name => $value) {
    $help = ucfirst(str_replace('_', ' ', $name));
    echo "# HELP {$prefix}_{$name} {$help}\n";
    echo "# TYPE {$prefix}_{$name} gauge\n";
    echo "{$prefix}_{$name} {$value}\n";
}
