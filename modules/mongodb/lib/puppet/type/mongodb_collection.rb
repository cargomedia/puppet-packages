Puppet::Type.newtype(:mongodb_collection) do
  @doc = "Manage MongoDB databases."

  ensurable

  newparam(:name, :namevar=>true) do
    desc "The name of the database."
    newvalues(/^\w+$/)
  end

  newparam(:tries) do
    desc "The maximum amount of two second tries to wait MongoDB startup."
    defaultto 10
    newvalues(/^\d+$/)
    munge do |value|
      Integer(value)
    end
  end

  newparam(:database) do
    desc "The database where collection belongs to"
  end

  newparam(:shard_enabled) do
    desc "Enabled sharding for collection(s) in database"
    defaultto false
  end

  newproperty(:shard_rules, :array_matching => :all) do
    desc "The collection sharding rules"
    defaultto []
  end

  newparam(:router) do
    desc "The cluster mongos/router instance"
    defaultto false
  end

end
