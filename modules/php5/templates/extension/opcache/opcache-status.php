<?php

$status = opcache_get_status(false);
$metrics = new RecursiveIteratorIterator(new RecursiveArrayIterator($status));
$prefix = 'php_opcache';

foreach ($metrics as $name => $value) {
    $help = ucfirst(str_replace('_', ' ', $name));
    echo "# HELP {$prefix}_{$name} {$help}\n";
    echo "# TYPE {$prefix}_{$name} gauge\n";
    echo "{$prefix}_{$name} {$value}\n";
}




