define janus_cluster::member (
  $id,
  $partition,
){

  $partitions = lookup('janus_cluster::partitions')
  $partition_config = $partitions[$partition]

  $partition_members = $partition_config['members']
  $partition_manager_params = $partition_config['manager']

  $origin_defaults = $partition_config['origin-defaults']
  $repater_defaults = $partition_config['repeater-defaults']
  $edge_defaults = $partition_config['edge-defaults']

  $member = $partition_members[$id]
  $member_params = $member['params']
  $member_type = $member['type']
  $member_upstream = $member['upstream']

  case $member_type {

    'origin': {
      $members_resource_config = {
        "${id}" => merge($origin_defaults, $member_params),
      }
    }

    'repeater': {
      $members_resource_config = {
        "${id}" => merge($repater_defaults, $member_params)
      }
    }

    'multiedge': {
      $multiedge_params = merge($edge_defaults, $member_params)
      $members_resource_config = janus_multiedge_config($id, $member, $multiedge_params)
    }

    default: {
      fail("Unknown janus role type ${member_type}")
    }
  }

  create_resources('janus::role::rtpbroadcast', $members_resource_config)

  # Configure register ticket of the member in the partition cluster manager
  if $partition_manager_params {
    $defaults = {
      'data' => {
        'rtpbroadcast' => {
          'role' => $member_type,
          'upstream' => $member_upstream
        }
      }
    }
    $members_configuration = janus_members_register($members_resource_config, $partition_manager_params)
    create_resources('janus_cluster_manager::member', $members_configuration, $defaults)
  }

}
