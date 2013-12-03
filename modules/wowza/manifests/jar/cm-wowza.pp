class wowza::jar::cm-wowza ($version = '0.0.1') {

  require 'wowza'

  helper::script {'install wowza:jar cm-wowza':
    content => template('wowza/jar/cm-wowza.sh'),
    unless => "test -f /usr/local/WowzaMediaServer/lib/ch.cargomedia.wms-${version}.jar",
  }

}
