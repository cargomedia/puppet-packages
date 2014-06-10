Puppet::Type.newtype(:mongodb_replset) do
  @doc = 'Manage a MongoDB replicaSet'

  ensurable

  newparam(:name) do
    desc 'The name of the replicaSet'
  end

  newproperty(:members, :array_matching => :all) do
    desc 'Hostnames of members'

    validate do |value|
      arbiter = @resources[:arbiter]
      if !arbiter.nil? and value.include?(arbiter)
        raise Puppet::Error, 'Members shouldnt contain arbiter'
      end
    end

    def insync?(is)
      is.sort == should.sort
    end
  end

  newparam(:arbiter) do
    desc 'Hostname of arbiter'
    defaultto nil
  end

  autorequire(:package) do
    'mongodb'
  end

  autorequire(:service) do
    'mongodb'
  end
end
