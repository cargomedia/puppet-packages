Puppet::Type.type(:mongodb_database).provide(:mongodb) do

  desc "Manages MongoDB database."

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
    mongo(@resource[:name], '--quiet', '--eval', "db.dummyData.insert({\"created_by_puppet\": 1})")
    if @resource[:shard] and !self.sh_issharded(@resource[:name], @resource[:router])
      self.sh_enable(@resource[:name], @resource[:router])
    end
  end

  def destroy
    mongo(@resource[:name], '--quiet', '--host', @resource[:router], '--eval', 'db.dropDatabase()')
  end

  def exists?
    block_until_mongodb(@resource[:tries])
    db_exists = mongo("--quiet", "--eval", 'db.getMongo().getDBNames()').split(",").include?(@resource[:name])
    if @resource[:ensure].to_s != 'absent' and @resource[:shard] and db_exists
      return self.sh_issharded(@resource[:name], @resource[:router])
    end
    db_exists
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

  def sh_enable(dbname, master)
    self.mongo_command("sh.enableSharding('#{dbname}')", master)
  end

  def sh_issharded(dbname, master)
    output = self.mongo('config', '--quiet', '--host', master, '--eval', "printjson(db.databases.find({\"_id\": \"#{dbname}\", \"partitioned\": true}).count())")
    1 == output.to_i
  end

end
