Puppet::Type.newtype(:mongodb_replset) do
  @doc = 'Manage a MongoDB replicaSet'

  ensurable

  newparam(:name) do
    desc 'The name of the replicaSet'
  end

  newproperty(:members, :array_matching => :all) do
    desc 'Hostnames of members'

    def insync?(is)
      is.sort == should.sort
    end
  end

  newproperty(:arbiters, :array_matching => :all) do
    desc 'Hostnames of arbiters'
    defaultto []

    def insync?(is)
      is.sort == should.sort
    end
  end

  autorequire(:package) do
    'mongodb'
  end

  autorequire(:service) do
    'mongodb'
  end

  autorequire(:file) do
    '/etc/mongorc.js'
  end
end
