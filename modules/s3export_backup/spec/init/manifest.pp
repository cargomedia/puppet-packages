node default {

  class { 's3export_backup':
    awsKey    => 'foo-key',
    awsSecret => 'foo-secret',
    awsRegion => 'foo-region',
    awsBucket => 'foo-bucket',
  }
}
