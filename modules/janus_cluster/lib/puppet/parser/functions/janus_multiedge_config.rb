module Puppet::Parser::Functions

  newfunction(:janus_multiedge_config, :type => :rvalue, :doc => <<-EOS
    Returns list of janus nodes splited by port ranges
  EOS
  ) do |args|

    member_id = args[0]
    multiedge_config = args[1]
    multiedge_params = args[2] || {}

    edge_count = multiedge_config['count']

    split_range = Proc.new { |min, max, count, index|
      size = ((max-min+1).to_f / count).round
      range = [min+size*(index), min+size*(index+1)-1]
      range[1] = max if index === (count-1)
      range
    }

    multiedge_port_config = Proc.new { |index, count, defaults|
      in_range = split_range.call(defaults['rtpb_minport'], defaults['rtpb_maxport'], count, index)
      out_range = split_range.call(defaults['rtp_port_range_min'], defaults['rtp_port_range_max'], count, index)
      {
          'http_port' => defaults['http_port'] + index,
          'ws_port' => defaults['ws_port'] + index,
          'rtpb_minport' => in_range.first,
          'rtpb_maxport' => in_range.last,
          'rtp_port_range_min' => out_range.first,
          'rtp_port_range_max' => out_range.last
      }
    }

    Hash[
        (1..edge_count).map do |edge_index|
          edge_port_config = multiedge_port_config.call(edge_index-1, edge_count, multiedge_params)
          ["#{member_id}#{edge_index}", multiedge_params.merge(edge_port_config)]
        end
    ]
  end

end
