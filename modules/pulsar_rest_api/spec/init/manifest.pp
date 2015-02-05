node default {

  require 'monit'

  class { 'pulsar_rest_api':
    mongodb_host   => 'localhost',
    mongodb_port   => 27017,

    pulsar_repo    => undef,
    pulsar_branch  => undef,

    auth           => {
      'github_oauth_id' => 'id',
      'github_oauth_secret' => 'secret',
      'github_org' => 'org',
      'base_url' => 'base_url',
      'callback_url' => 'callback_url',
    },
  }
}
