node default {

  class { 'nginx':
    server_names_hash_bucket_size => 64,
    server_names_hash_max_size => 1024,
  }
}
