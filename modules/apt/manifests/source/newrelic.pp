class apt::source::newrelic {

  apt::source {'newrelic':
    entries => ['deb http://apt.newrelic.com/debian/ newrelic non-free'],
    keys => {
      'newrelic' => {
        key     => '548C16BF',
        key_url => 'http://download.newrelic.com/548C16BF.gpg',
      }
    }
  }
}

