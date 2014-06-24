require 'puppet/provider/mongodb'

Puppet::Type.type(:mongodb_collection).provide :mongodb, :parent => Puppet::Provider::Mongodb do

  desc 'Manages MongoDB collections.'

  defaultfor :kernel => 'Linux'

  def create
    mongo_command("db.createCollection('#{@resource[:name]}')", @resource[:router], @resource[:database])
    if :true == resource.should(:shard)
      sh_shard_collection(@resource[:name], @resource[:database], @resource[:shard_key], @resource[:router])
    end
  end

  def destroy
    raise Puppet::Error, 'Not implemented'
  end

  def exists?
    block_until_command
    collection_names = db_collections(@resource[:database], @resource[:router])
    collection_names.include?(@resource[:name])
  end

  def shard
    issharded = db_collection_sharded?(@resource[:name], @resource[:database], @resource[:router])
    issharded ? :true : :false
  end

  def shard=(value)
    if :true == value
      sh_shard_collection(@resource[:name], @resource[:database], @resource[:shard_key], @resource[:router])
    else
      raise Puppet::Error, "Cannot disable sharding for collection `#{@resource[:name]}`"
    end
  end

  private

  def db_collections(dbname, master)
    mongo_command_json("db.getMongo().getDB('#{dbname}').getCollectionNames()", master)
  end

  def db_collection_stats(collection, dbname, master)
    mongo_command_json("db.getMongo().getDB('#{dbname}').getCollection('#{collection}').stats()", master)
  end

  def db_collection_sharded?(collection, dbname, master)
    db_collection_stats(collection, dbname, master)['sharded']
  end

  def sh_shard_collection(collection, dbname, key, master)
    output = mongo_command_json("sh.shardCollection(\"#{dbname}.#{collection}\", {'#{key}': 1})", master)
    if output['ok'] == 0
      raise Puppet::Error, "sh.shardCollection() failed for #{dbname}.#{collection}: #{output['errmsg']}"
    end
  end

end
