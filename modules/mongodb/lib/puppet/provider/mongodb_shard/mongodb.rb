Puppet::Type.type(:mongodb_shard).provide(:mongodb) do

  desc "Manage shards for a MongoDB cluster."

  defaultfor :kernel => 'Linux'

  commands :mongo => 'mongo'

  def block_until_mongodb(tries = 10)
    begin
      mongo('--quiet', '--host', @resource[:name], '--eval', 'db.getMongo()')
      mongo('--quiet', '--host', @resource[:router], '--eval', 'db.getMongo()')
    rescue
      debug('MongoDB server not ready, retrying')
      sleep 2
      raise("Cannot connect to MongoDB router instance #{@resource[:router]} or host @resource[:name]") if (tries -= 1) <= 0
      retry
    end
  end

  def create
    repl_set = ''
    if !@resource[:repl_set].to_s.empty?
      repl_set = @resource[:repl_set] + '/'
    end
    sh_add("#{repl_set}#{@resource[:name]}", @resource[:router])
  end

  def destroy
    fail('Not implemented')
  end

  def exists?
    block_until_mongodb
    sh_isshard(@resource[:name], @resource[:router])
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

  def sh_isshard(host, master)
    output = self.mongo('config', '--quiet', '--host', master, '--eval', "printjson(db.shards.find({\"host\": /#{host}/}).count())")
    output.to_i > 0
  end

  def sh_add(host, master)
    self.mongo_command("sh.addShard(\"#{host}\")", master)
  end

end
