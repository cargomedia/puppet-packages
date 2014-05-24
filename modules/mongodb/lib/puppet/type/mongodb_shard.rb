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

  newparam(:collection) do
    desc "The collection name to enable partitioning"
  end

  newparam(:rules, :array_matching => :all) do
    desc "The collection partitioning rules"
  end

  newparam(:router) do
    desc "The cluster mongos/router instance"
  end

end
