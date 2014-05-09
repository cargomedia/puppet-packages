class wowza::jar::json-simple($version = '1.1.1') {

  require 'wowza'

  wowza::jar {'json-simple':
    get_command => "curl -sL http://json-simple.googlecode.com/files/json-simple-${version}.jar",
    version => $version,
  }
}
