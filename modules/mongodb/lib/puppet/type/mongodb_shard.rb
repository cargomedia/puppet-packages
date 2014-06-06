Puppet::Type.newtype(:mongodb_shard) do
  @doc = 'Manage a MongoDB shards.'

  ensurable

  newparam(:name, :namevar => true) do
    desc "The name of the shard database."
  end

  newparam(:repl_set) do
    desc "The shard replica set"

    defaultto ''
  end

  newparam(:router) do
    desc "The cluster mongos/router instance"

    validate do |value|
      parts = value.split(':')
      host = parts[0]
      port = parts[1]

      host.split('.').each do |hostpart|
        unless hostpart =~ /^([\d\w]+|[\d\w][\d\w\-]+[\d\w])$/
          raise Puppet::Error, "Invalid host name for router"
        end
      end

      if port.nil?
        raise Puppet::Error, "Invalid port number for router"
      end
    end

    defaultto do
      fail("Property 'router' must be set to setup shard")
    end
  end

end
