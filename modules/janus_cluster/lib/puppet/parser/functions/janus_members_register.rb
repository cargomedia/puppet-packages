module Puppet::Parser::Functions
  newfunction(:janus_members_register, :type => :rvalue, :doc => <<-EOS
    Return list of janus nodes for janus-cluster-manager member registration
  EOS
  ) do |args|

    members = args[0]
    manager = args[1] || {}

    Hash[
        members.map do |id, config|
          member_ws_address = "ws://#{config['hostname']}:#{config['ws_port']}"
          member_config = manager.merge({:web_socket_address => member_ws_address})
          [id, member_config]
        end
    ]
  end
end
