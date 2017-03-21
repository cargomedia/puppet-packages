node default {

  class { 's3export_backup':
    aws_version => 'foo-version',
    aws_region  => 'foo-region',
    aws_bucket  => 'foo-bucket',
    aws_key     => 'foo-key',
    aws_secret  => 'foo-secret',
  }
}
