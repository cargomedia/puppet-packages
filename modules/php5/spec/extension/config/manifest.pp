node default {

  class {'php5':}

  php5::extension::config{'foo':
    settings => {
      'foo.bar' => 'bob'
    }
  }

}
