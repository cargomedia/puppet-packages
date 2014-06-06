class Puppet::Provider::Mongodb < Puppet::Provider

  def block_until_mongodb(host = @resource[:router], tries = 10)
    begin
      mongo('--quiet', '--host', host, '--eval', 'db.getMongo()')
    rescue
      debug('MongoDB server not ready, retrying')
      sleep 2
      raise("Cannot connect to MongoDB router instance #{host}") if (tries -= 1) <= 0
      retry
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
    output.gsub!(/ObjectId\((.+?)\)/, '1')

    JSON.parse(output)
  end

end
