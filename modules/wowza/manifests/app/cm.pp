class wowza::app::cm (
  $rpc_url = 'https://www.fuckbook.com/rpc/null',
  $archive_dir = '/home/fuckbook/shared/userfiles/streamChannels'
) {

  class {'wowza::jar::cm-wowza':
    version => '0.0.1',
  }

}
