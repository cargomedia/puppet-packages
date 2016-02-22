Puppet::Type.newtype(:mongodb_database) do
  @doc = 'Manage MongoDB databases.'

  ensurable

  newparam(:name, :namevar => true) do
    desc 'The name of the database.'
    newvalues(/^\w+$/)
  end

  newparam(:router) do
    desc 'The cluster mongos/router instance'

    newvalues(/^[^:]+:\d+$/)

    defaultto do
      if :true == @resource[:shard]
        fail("Property 'router' must be set to setup sharding for database `#{@resource[:name]}`")
      end
      'localhost:27017'
    end
  end

  newproperty(:shard, :boolean => true) do
    desc 'Enable sharding for database.'
    newvalues(:true, :false)
    defaultto :false
  end

  autorequire(:file) do
    '/etc/mongorc.js'
  end
end
