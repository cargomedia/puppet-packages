node default {

  class { 'pulsar_rest_api':
    mongodb_host   => 'localhost',
    mongodb_port   => 27017,

    pulsar_repo    => 'foo/bar',
    pulsar_branch  => 'master',

    authentication => {
      'github_oauth_id' => 'id',
      'github_oauth_secret' => 'secret',
      'github_org' => 'org',
      'base_url' => 'base_url',
      'authorization' => {
        'read' => ['read-org', 'read-user'],
        'write' => ['write-org'],
      }
    },
  }
}
