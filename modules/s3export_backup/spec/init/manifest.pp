node default {

  class { 's3export_backup':
    awsKey    => 'aws-key',
    awsSecret => 'aws-secret',
    awsRegion => 'aws-region',
    awsBucket => 'aws-bucket',
  }
}
