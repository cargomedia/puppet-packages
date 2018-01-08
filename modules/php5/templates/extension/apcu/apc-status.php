<?php

$infoOpcode = @apc_cache_info('opcode', true);
$infoUser = @apc_cache_info('user', true);
$infoAlloc = @apc_sma_info(true);

// see https://github.com/krakjoe/apcu/blob/master/apc.php#L754
$total_mem_size = (int) $infoAlloc['num_seg'] * (int) $infoAlloc['seg_size'];
$avail_mem_size = (int) $infoAlloc['avail_mem'];
$used_mem_size = $total_mem_size - $avail_mem_size;

echo json_encode(array(
    'opcode_mem_size' => (int) $infoOpcode['mem_size'],
    'user_mem_size'   => (int) $infoUser['mem_size'],
    'total_mem_size'  => $total_mem_size,
    'avail_mem_size'  => $avail_mem_size,
    'used_mem_size'   => $used_mem_size,
));
