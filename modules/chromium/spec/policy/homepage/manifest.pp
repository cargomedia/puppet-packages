node default {

  class { 'chromium::policy::homepage':
    url => 'http://www.example.com',
  }

}
