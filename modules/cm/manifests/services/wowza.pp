class cm::services::wowza(
  $path,
  $rpc_url,
  $license = undef
) {

  class {'::wowza':
    license => $license,
  }

  class {'::wowza::app::cm':
    rpc_url => $rpc_url,
    cm_bin_path => "${path}/bin/cm",
  }

}
