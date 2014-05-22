Puppet::Type.type(:mongodb_shard).provide(:mongodb) do

  desc "Manage shards for a MongoDB cluster."

  defaultfor :kernel => 'Linux'

  commands :mongo => 'mongo'

  def create
  end

  def destroy
  end

  def exists?
  end

  def collections_rules
  end

  def collections_rules(settings)
    if settings.empty? then
      # apply default sharding for all
    end
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

  def sh_status(master)
    return self.mongo_command("rs.status()", master)
  end

  def sh_add(host, master)
    self.mongo_command("sh.addShard(\"#{host}\")", master)
  end

  def sh_enable(dbname, master)
    self.mongo_command("sh.enableSharding(#{dbname})", master)
  end

  def sh_collection_add(collection, dbname, key, unique, master)
    self.mongo_command("sh.shardCollection(\"#{dbname}.#{collection}\", \"#{key}\", \"#{unique}\")", master)
  end

end
