Puppet::Type.newtype(:mongodb_replset) do
  @doc = "Manage a MongoDB replicaSet"

  ensurable

  newparam(:name) do
    desc "The name of the replicaSet"
  end

  newproperty(:members, :array_matching => :all) do
    desc "The replicaSet members"

    def insync?(is)
      is.sort == should.sort
    end
  end

  newparam(:arbiter) do
    desc "Set if host is an arbiter of replicaset"
    defaultto false
  end

  autorequire(:package) do
    'mongodb'
  end

  autorequire(:service) do
    'mongodb'
  end
end
