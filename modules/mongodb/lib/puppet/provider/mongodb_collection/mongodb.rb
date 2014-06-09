require 'puppet/provider/mongodb'

Puppet::Type.type(:mongodb_collection).provide :mongodb, :parent => Puppet::Provider::Mongodb do

  desc "Manages MongoDB collections."

  defaultfor :kernel => 'Linux'

  commands :mongo => 'mongo'

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
      mongo(@resource[:database], '--quiet', '--host', @resource[:router], '--eval', "db.createCollection('#{@resource[:name]}')")
      if @resource[:shard_enabled]
        if !sh_issharded(@resource[:name], @resource[:database], @resource[:router])
          sh_shard(@resource[:name], @resource[:database], @resource[:shard_key], @resource[:router])
        end
      end
    end
  end

  def destroy
    mongo(@resource[:database], '--quiet', '--host', @resource[:router], '--eval', "db.#{@resource[:name]}.drop()")
  end

  def exists?
    block_until_command

    if @resource[:name] == "#{@resource[:database]}.all"
      return false
    end

    col_exists = mongo('--quiet', '--host', @resource[:router],
                       '--eval', "db.getMongo().getDB('#{@resource[:database]}').getCollectionNames()").split(",").include?(@resource[:name])
    if @resource[:ensure].to_s != 'absent' and @resource[:shard_enabled] and col_exists
      return sh_issharded(@resource[:name], @resource[:database], @resource[:router])
    end
    col_exists
  end

  def db_collections(dbname, master)
    self.mongo_command_json("db.getMongo().getDB('#{@resource[:database]}').getCollectionNames()", master)
  end

  def sh_shard(collection, dbname, key, master)
    self.mongo_command_json("sh.shardCollection(\"#{dbname}.#{collection}\", {'#{key}': 1})", master)
  end

  def sh_status(collection, dbname, master)
    self.mongo_command_json("db.getMongo().getDB('#{dbname}').getCollection('#{collection}').stats()", master)
  end

  def sh_issharded(collection, dbname, master)
    self.sh_status(collection, dbname, master)['sharded']
  end

end
