#
# Author: Cargomedia <hello@cargomedia.ch>
#

Puppet::Type.newtype(:mongodb_shard) do
  @doc = 'Manage a MongoDB shards.'

  ensurable do
    defaultto :present

    newvalue(:present) do
      provider.create
    end
  end

  newparam(:name, :namevar=>true) do
    desc "The name of the shard database."
  end

  newparam(:tries) do
    desc "The maximum amount of two second tries to wait MongoDB startup."
    defaultto 10
    newvalues(/^\d+$/)
    munge do |value|
      Integer(value)
    end
  end

  newparam(:router) do
    desc "The cluster mongos/router instance"
    defaultto false
  end

end
