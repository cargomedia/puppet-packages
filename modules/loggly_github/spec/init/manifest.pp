node default {

  class { 'loggly_github':
    port         => 1234,
    secret       => 'my-api-secret',
    github_token => 'my-github-token',
  }
}
