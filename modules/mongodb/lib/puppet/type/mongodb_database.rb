Puppet::Type.newtype(:mongodb_database) do
  @doc = "Manage MongoDB databases."

  ensurable

  attr_accessor :shard

  newparam(:name, :namevar => true) do
    desc "The name of the database."
    newvalues(/^\w+$/)
  end

  newparam(:router) do
    desc "The cluster mongos/router instance"

    newvalues(/^[^:]+:\d+$/)

    defaultto do
      if @resource[:shard]
        fail("Property 'router' must be set to setup sharding for database `#{@resource[:name]}`")
      end
      'localhost:27017'
    end
  end

  newparam(:shard) do
    desc "Enable sharding for database."
    defaultto false
  end

end
