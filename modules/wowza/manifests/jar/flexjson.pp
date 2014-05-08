class wowza::jar::flexjson($version = '2.1') {

  require 'wowza'

  helper::script {'install wowza:jar flex-json':
    content => template('wowza/jar/flexjson.sh'),
    unless => "test -f /usr/local/WowzaStreamingEngine/lib/lib-versions/flexjson-${version}.jar",
    user => 'wowza',
  }

}
