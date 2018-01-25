<?php

$infoOpcode = @apc_cache_info('opcode', true);
$infoUser = @apc_cache_info('user', true);
$infoAlloc = @apc_sma_info(true);

// see https://github.com/krakjoe/apcu/blob/master/apc.php#L754
$total_mem_size = (int) $infoAlloc['num_seg'] * (int) $infoAlloc['seg_size'];
$avail_mem_size = (int) $infoAlloc['avail_mem'];
$used_mem_size = $total_mem_size - $avail_mem_size;
$used_mem_percentage = $used_mem_size / $total_mem_size;

$prefix = 'php';
$metrics = [
    [
        'name'  => 'apc_opcode_memory_bytes',
        'type'  => 'gauge',
        'value' => (int) $infoOpcode['mem_size'],
    ],
    [
        'name'  => 'apc_user_memory_bytes',
        'type'  => 'gauge',
        'value' => (int) $infoUser['mem_size'],
    ],
    [
        'name'  => 'apc_used_memory_bytes',
        'type'  => 'gauge',
        'value' => $used_mem_size,
    ],
    [
        'name'  => 'apc_used_memory_ratio',
        'type'  => 'gauge',
        'value' => $used_mem_percentage,
    ],
];

foreach ($metrics as $metric) {
    $name = $metric['name'];
    $help = ucfirst(str_replace('_', ' ', $name));
    echo "# HELP {$prefix}_{$name} {$help}\n";
    echo "# TYPE {$prefix}_{$name} {$metric['type']}\n";
    echo "{$prefix}_{$name} {$metric['value']}\n";
}
