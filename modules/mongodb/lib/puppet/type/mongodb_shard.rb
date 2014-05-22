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

  newparam(:router, :namevar=>true) do
    desc "The cluster mongos/router instance."
  end

  newparam(:collections_rules, :array_matching => :all) do
    desc "The database collections to shard"
  end

end
