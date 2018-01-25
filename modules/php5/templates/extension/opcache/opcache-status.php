<?php
$status = opcache_get_status(false);
$prefix = 'php';
$metrics = [
    [
        'name'  => 'opcache_free_memory_bytes',
        'type'  => 'gauge',
        'value' => $status['memory_usage']['free_memory'],
    ],
    [
        'name'  => 'opcache_current_wasted_ratio',
        'type'  => 'gauge',
        'value' => $status['memory_usage']['current_wasted_percentage'],
    ],
    [
        'name'  => 'opcache_num_cached_keys',
        'type'  => 'gauge',
        'value' => $status['opcache_statistics']['num_cached_keys'],
    ],
    [
        'name'  => 'opcache_hit_rate_ratio',
        'type'  => 'gauge',
        'value' => $status['opcache_statistics']['opcache_hit_rate'],
    ],
    [
        'name'  => 'opcache_misses_total',
        'type'  => 'counter',
        'value' => $status['opcache_statistics']['misses'],
    ],
    [
        'name'  => 'opcache_hits_total',
        'type'  => 'counter',
        'value' => $status['opcache_statistics']['hits'],
    ],
    [
        'name'  => 'opcache_oom_restarts_total',
        'type'  => 'counter',
        'value' => $status['opcache_statistics']['oom_restarts'],
    ],
];

foreach ($metrics as $metric) {
    $name = $metric['name'];
    $help = ucfirst(str_replace('_', ' ', $name));
    echo "# HELP {$prefix}_{$name} {$help}\n";
    echo "# TYPE {$prefix}_{$name} {$metric['type']}\n";
    echo "{$prefix}_{$name} {$metric['value']}\n";
}
