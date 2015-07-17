class wowza::jar::flexjson($version = '2.1') {

  require 'wowza'

  wowza::jar { 'flexjson':
    get_command => "curl -sL http://central.maven.org/maven2/net/sf/flexjson/flexjson/${version}/flexjson-${version}.jar",
    version     => $version,
  }
}
