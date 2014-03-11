node default {

  composer::config {'composer-github':
    user => 'root',
    user_home => '/root',
    github_oauth => 'github-token'
  }

}
