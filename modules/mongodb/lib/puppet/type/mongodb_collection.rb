Puppet::Type.newtype(:mongodb_collection) do
  @doc = "Manage MongoDB databases."

  ensurable

  newparam(:name, :namevar=>true) do
    desc 'The name of the collection.'
    newvalues(/^\w+\.?\w+$/)
  end

  newparam(:database) do
    desc 'The database where collection belongs to'
  end

  newproperty(:shard_enabled, :boolean => true) do
    desc 'Enabled sharding for collection(s) in database'
    newvalues(:true, :false)
    defaultto :false
  end

  newparam(:shard_key) do
    desc 'The collection sharding key'
    defaultto '_id'
  end

  newparam(:router) do
    desc 'The cluster mongos/router instance'

    newvalues(/^[^:]+:\d+$/)

    defaultto do
      if :true == @resource[:shard_enabled]
        fail("Property 'router' must be set to enable and setup sharding for collections")
      end
      'localhost:27017'
    end
  end

end
