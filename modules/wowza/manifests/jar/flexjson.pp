class wowza::jar::flexjson($version = '2.1') {

  require 'wowza'

  wowza::jar {'flexjson':
    get_command => "curl -sL http://downloads.sourceforge.net/project/flexjson/flexjson/flexjson%20${version}/flexjson-${version}.tar.gz | tar -xzvO flexjson-${version}/flexjson-${version}.jar",
    version => $version,
  }
}
