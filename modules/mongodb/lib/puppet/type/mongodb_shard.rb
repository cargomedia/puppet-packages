Puppet::Type.newtype(:mongodb_shard) do
  @doc = 'Manage a MongoDB shards.'

  ensurable

  def initialize(*args)
    super
  end

  newparam(:name, :namevar=>true) do
    desc "The name of the shard."
  end

end
