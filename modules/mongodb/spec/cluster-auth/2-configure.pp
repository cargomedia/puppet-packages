node default {

  $cluster_config = hiera('mongodb_config')
  $cluster_admin_users = $cluster_config['admin-users']
  $cluster_mongorc_autologin = $cluster_config['mongorc-autologin-user']

  create_resources('mongodb_user', $cluster_admin_users)

  if $cluster_mongorc_autologin {
    $autologin_user = $cluster_admin_users[$cluster_mongorc_autologin]

    $mongorc_autologin_config = {
      "mongorc-user-${$cluster_mongorc_autologin}" => {
        username => $cluster_mongorc_autologin,
        password => $autologin_user['password'],
        database => $autologin_user['database']
      }
    }

    create_resources('mongodb::mongorc::autologin', $mongorc_autologin_config)
  }
}
