Puppet::Type.type(:mongodb_collection).provide(:mongodb) do

  desc "Manages MongoDB collections."

  defaultfor :kernel => 'Linux'

  commands :mongo => 'mongo'

  def block_until_mongodb(tries = 10)
    begin
      mongo('--quiet', '--host', @resource[:router], '--eval', 'db.getMongo()')
    rescue
      debug('MongoDB server not ready, retrying')
      sleep 2
      retry unless (tries -= 1) <= 0
    end
  end

  def create
    if @resource[:name] == '__all__'
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
    if @resource[:name] == '__all__'
      return false
    end

    block_until_mongodb
    col_exists = mongo('--quiet', '--host', @resource[:router],
                       '--eval', "db.getMongo().getDB('#{@resource[:database]}').getCollectionNames()").split(",").include?(@resource[:name])
    if @resource[:ensure].to_s != 'absent' and @resource[:shard_enabled] and col_exists
      return sh_issharded(@resource[:name], @resource[:database], @resource[:router])
    end
    col_exists
  end

  def mongo_command(command, host, retries=4)
    # Allow waiting for mongod to become ready
    # Wait for 2 seconds initially and double the delay at each retry
    wait = 2
    begin
      output = self.mongo('--quiet', '--host', host, '--eval', "printjson(#{command})")
    rescue Puppet::ExecutionFailure => e
      if e =~ /Error: couldn't connect to server/ and wait <= 2**max_wait
        info("Waiting #{wait} seconds for mongod to become available")
        sleep wait
        wait *= 2
        retry
      else
        raise
      end
    end

    # Dirty hack to remove JavaScript objects
    output.gsub!(/ISODate\((.+?)\)/, '\1 ')
    output.gsub!(/Timestamp\((.+?)\)/, '[\1]')
    output.gsub!(/ObjectId\((.+?)\)/, '1')

    JSON.parse(output)
  end

  def db_collections(dbname, master)
    self.mongo_command("db.getMongo().getDB('#{@resource[:database]}').getCollectionNames()", master)
  end

  def sh_shard(collection, dbname, key, master)
    self.mongo_command("sh.shardCollection(\"#{dbname}.#{collection}\", {'#{key}': 1})", master)
  end

  def sh_status(collection, dbname, master)
    self.mongo_command("db.getMongo().getDB('#{dbname}').getCollection('#{collection}').stats()", master)
  end

  def sh_issharded(collection, dbname, master)
    self.sh_status(collection, dbname, master)['sharded']
  end

end
