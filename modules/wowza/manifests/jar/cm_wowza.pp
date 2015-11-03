class wowza::jar::cm_wowza($version = '0.2.1') {

  require 'wowza'
  require 'wowza::jar::flexjson'
  require 'wowza::jar::json_simple'

  wowza::jar { 'ch.cargomedia.wms':
    get_command => "curl -sL https://github.com/cargomedia/CM-wowza/releases/download/v${version}/ch.cargomedia.wms.jar",
    version     => $version,
  }
}
