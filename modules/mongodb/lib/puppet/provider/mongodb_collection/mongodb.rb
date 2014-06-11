require 'puppet/provider/mongodb'

Puppet::Type.type(:mongodb_collection).provide :mongodb, :parent => Puppet::Provider::Mongodb do

  desc "Manages MongoDB collections."

  defaultfor :kernel => 'Linux'

  def create
    if @resource[:name] == "#{@resource[:database]}.all"
      if @resource[:shard_enabled]
        collections = db_collections(@resource[:database], @resource[:router])
        collections.each do |collection|
          if !sh_issharded(collection, @resource[:database], @resource[:router])
            sh_shard(collection, @resource[:database], @resource[:shard_key], @resource[:router])
          end
        end
      end
    else
      mongo_command("db.createCollection('#{@resource[:name]}')", @resource[:router], @resource[:database])
      if @resource[:shard_enabled]
        if !sh_issharded(@resource[:name], @resource[:database], @resource[:router])
          sh_shard(@resource[:name], @resource[:database], @resource[:shard_key], @resource[:router])
        end
      end
    end
  end

  def destroy
    mongo_command("db.#{@resource[:name]}.drop()", @resource[:router], @resource[:database])
  end

  def exists?
    # @todo loop over all collections
    block_until_command

    if @resource[:name] == "#{@resource[:database]}.all"
      return false
    end

    collection_names = db_collections(@resource[:database], @resource[:router])
    col_exists = collection_names.include?(@resource[:name])
    if @resource[:ensure].to_s != 'absent' and @resource[:shard_enabled] and col_exists
      return sh_issharded(@resource[:name], @resource[:database], @resource[:router])
    end
    col_exists
  end

  def db_collections(dbname, master)
    mongo_command_json("db.getMongo().getDB('#{dbname}').getCollectionNames()", master)
  end

  def sh_shard(collection, dbname, key, master)
    mongo_command_json("sh.shardCollection(\"#{dbname}.#{collection}\", {'#{key}': 1})", master)
  end

  def sh_status(collection, dbname, master)
    mongo_command_json("db.getMongo().getDB('#{dbname}').getCollection('#{collection}').stats()", master)
  end

  def sh_issharded(collection, dbname, master)
    sh_status(collection, dbname, master)['sharded']
  end

end
