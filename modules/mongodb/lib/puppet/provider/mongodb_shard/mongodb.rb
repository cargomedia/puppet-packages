Puppet::Type.type(:mongodb_shard).provide(:mongodb) do

  desc "Manage shards for a MongoDB cluster."

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
  end

  def destroy
  end

  def exists?
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
    self.mongo_command("rs.status()", master)
  end

  def rs_ismember
    # is member of replica set?
  end

  def rs_isprimary
    # check if is member of replica?
    # if member then check if primary?
  end

  def sh_add(host, master)
    self.mongo_command("sh.addShard(\"#{host}\")", master)
  end

end
