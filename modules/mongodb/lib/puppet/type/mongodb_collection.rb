Puppet::Type.newtype(:mongodb_collection) do
  @doc = "Manage MongoDB databases."

  ensurable

  newparam(:name, :namevar => true) do
    desc 'The name of the collection.'
    newvalues(/^.+$/)
  end

  newparam(:database) do
    desc 'The database where collection belongs to'
  end

  newproperty(:shard, :boolean => true) do
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
      if :true == @resource[:shard]
        fail("Property 'router' must be set to enable and setup sharding for collections")
      end
      'localhost:27017'
    end
  end

  autorequire(:mongodb_database) do
    self.catalog.resources.select { |res|
      res.type == :mongodb_database and res[:name] == self[:database]
    }.map { |res|
      res[:name]
    }
  end

  autorequire(:file) do
    '/etc/mongorc.js'
  end
end
