node default {

  class {'wowza':
    version => '3.5.0',
  }

  class {'wowza::app::cm': }

  class {'wowza::jar::flexjson':
    version => '2.1',
  }

  class {'wowza::jar::json-simple':
    version => '1.1.1',
  }

}