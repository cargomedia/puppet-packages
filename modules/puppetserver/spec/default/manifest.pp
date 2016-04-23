node default {

  class { 'puppet::common':
    gems => [
      'deep_merge',
      'i18n',
    ],
  }

  class { 'puppetserver':
    port => 1234,
  }

}
