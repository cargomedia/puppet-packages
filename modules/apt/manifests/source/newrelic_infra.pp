class apt::source::newrelic_infra {

  apt::source { 'newrelic-infra':
    entries => [
      "deb https://download.newrelic.com/infrastructure_agent/linux/apt/ ${::facts['lsbdistcodename']} main",
    ],
    keys    => {
      'newrelic-infra' => {
        key        => '8ECCE87C',
        key_url    => 'https://download.newrelic.com/infrastructure_agent/gpg/newrelic-infra.gpg',
      }
    }
  }
}
