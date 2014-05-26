Puppet::Type.newtype(:mongodb_user) do
  @doc = 'Manage a MongoDB user. This includes management of users password as well as privileges.'

  ensurable

  def initialize(*args)
    super
    # Sort roles array before comparison.
    self[:roles] = Array(self[:roles]).sort!
  end

  newparam(:name, :namevar=>true) do
    desc "The name of the user."
  end

  newparam(:database) do
    desc "The user's target database."
    defaultto do
      fail("Parameter 'database' must be set")
    end
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

  newproperty(:roles, :array_matching => :all) do
    desc "The user's roles."
    defaultto ['dbAdmin']
    newvalue(/^\w+$/)

    # Pretty output for arrays.
    def should_to_s(value)
      value.inspect
    end

    def is_to_s(value)
      value.inspect
    end
  end

  newproperty(:password_hash) do
    desc "The password hash of the user. Use mongodb_password() for creating hash."
    defaultto do
      fail("Property 'password_hash' must be set. Use mongodb_password() for creating hash.")
    end
    newvalue(/^\w+$/)
  end

  newparam(:router) do
    desc "The cluster mongos/router instance"

    validate do |value|
      parts = value.split(':')
      host = parts[0]
      port = parts[1]

      host.split('.').each do |hostpart|
        unless hostpart =~ /^([\d\w]+|[\d\w][\d\w\-]+[\d\w])$/
          raise Puppet::Error, "Invalid host name for router"
        end
      end

      if port.nil?
        raise Puppet::Error, "Invalid port number for router"
      end
    end

    defaultto false
  end

end
