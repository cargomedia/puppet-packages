node default {

  class { 'nginx':
    server_names_hash_bucket_size => 64,
  }
}
