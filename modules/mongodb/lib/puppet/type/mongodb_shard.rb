Puppet::Type.newtype(:mongodb_shard) do
  @doc = 'Manage a MongoDB shards.'

  ensurable

  newparam(:name, :namevar => true) do
    desc 'The name of the shard database.'

    newvalues(/^[^:]+:\d+$/)
  end

  newparam(:repl_set) do
    desc 'The shard replica set'

    defaultto ''
  end

  newparam(:router) do
    desc 'The cluster mongos/router instance'

    newvalues(/^[^:]+:\d+$/)

    defaultto do
      fail("Property 'router' must be set to setup shard")
    end
  end

  autorequire(:file) do
    '/etc/mongorc.js'
  end
end
