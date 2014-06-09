class wowza::jar::cm-wowza($version = '0.1.1') {

  require 'wowza'
  require 'wowza::jar::flexjson'
  require 'wowza::jar::json-simple'

  wowza::jar {'ch.cargomedia.wms':
    get_command => "curl -sL https://github.com/cargomedia/CM-wowza/releases/download/v${version}/ch.cargomedia.wms.jar",
    version => $version,
  }
}
