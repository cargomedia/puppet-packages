module Puppet::Parser::Functions
  newfunction(:janus_members, :type => :rvalue, :doc => <<-EOS
    Return lists of janus members for the node in the partition
  EOS
  ) do |args|
    node_partition = args[0]
    node_members = args[1]

    Hash[
        node_members.map do |id|
          member_params = {'id' => id, 'partition' => node_partition}
          [id, member_params]
        end
    ]
  end
end
