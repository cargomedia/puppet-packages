Puppet::Type.newtype(:mongodb_user) do
  @doc = 'Manage a MongoDB user. This includes management of users password as well as privileges.'

  ensurable

  newparam(:name, :namevar => true) do
    desc 'The name of the user.'
  end

  newparam(:username) do
    desc 'The name of the user.'
    newvalues(/^\w+$/)
    defaultto do
      @resource[:name]
    end
  end

  newparam(:database) do
    desc "The user's target database."
    defaultto do
      fail("Parameter 'database' must be set")
    end
    newvalues(/^\w+$/)
  end

  newproperty(:roles, :array_matching => :all) do
    desc "The user's roles."
    defaultto do
      {'role' => 'dbAdmin', 'db' => @resource[:database]}
    end

    def insync?(is)
      is.sort == should.sort
    end

    def should_to_s(value)
      value.inspect
    end

    def is_to_s(value)
      value.inspect
    end
  end

  newproperty(:password) do
    desc 'The password of the user.'
    newvalue(/^.+$/)
  end

  newparam(:router) do
    desc 'The cluster mongos/router instance'

    newvalues(/^[^:]+:\d+$/)

    defaultto 'localhost:27017'
  end

  autorequire(:mongodb_database) do
    self.catalog.resources.select { |res|
      res.type == :mongodb_database and res[:name] == self[:database]
    }.map { |res|
      res[:name]
    }
  end

end
