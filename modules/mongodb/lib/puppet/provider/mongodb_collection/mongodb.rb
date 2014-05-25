Puppet::Type.type(:mongodb_collection).provide(:mongodb) do

  desc "Manages MongoDB collections."

  defaultfor :kernel => 'Linux'

  commands :mongo => 'mongo'

  def block_until_mongodb(tries = 10)
    begin
      mongo('--quiet', '--eval', 'db.getMongo()')
    rescue
      debug('MongoDB server not ready, retrying')
      sleep 2
      retry unless (tries -= 1) <= 0
    end
  end

  def create
    collection_name = @resource[:name]
    mongo(@resource[:database], '--quiet', '--eval', "db.createCollection(#{collection_name})")
  end

  def destroy
    collection_name = @resource[:name]
    mongo(@resource[:database], '--quiet', '--eval', "db.#{collection_name}.drop()")
  end

  def exists?
    block_until_mongodb(@resource[:tries])
    db_name = @resource[:database]
    mongo("--quiet", "--eval", "db.getMongo().getDB('#{db_name}').getCollectionNames()").split(",").include?(@resource[:name])
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
    JSON.parse(output)
  end

  def rules
    {}
  end

  def rules(settings)
    if settings.empty? then
      # apply default sharding for all
    end
  end

  def sh_shard_col(collection, dbname, key, unique, master)
    self.mongo_command("sh.shardCollection(\"#{dbname}.#{collection}\", \"#{key}\", \"#{unique}\")", master)
  end

  def sh_issharded(collection, dbname, master)
  end

  def sh_status_col(collection, dbname, master)
    self.mongo_command("db.#{collection}.stats()", master)
  end

end
