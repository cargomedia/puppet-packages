class janus_cluster::node (
  $partition,
  $members,
) {

  create_resources('janus_cluster::member', janus_members($partition, $members))
}
