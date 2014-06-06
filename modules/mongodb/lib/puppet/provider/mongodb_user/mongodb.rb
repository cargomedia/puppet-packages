Puppet::Type.type(:mongodb_user).provide(:mongodb) do

  desc "Manage users for a MongoDB database."

  defaultfor :kernel => 'Linux'

  commands :mongo => 'mongo'

  def block_until_mongodb(tries = 10)
    begin
      mongo('--quiet', '--host', @resource[:router], '--eval', 'db.getMongo()')
    rescue
      debug('MongoDB server not ready, retrying')
      sleep 2
      raise("Cannot connect to MongoDB router instance #{@resource[:router]} or host @resource[:name]") if (tries -= 1) <= 0
      retry
    end
  end

  def create
    roles = JSON.dump @resource[:roles]
    mongo(@resource[:database], '--host', @resource[:router], '--eval', "db.createUser({user:\"#{@resource[:name]}\", pwd:\"#{@resource[:password_hash]}\", roles: #{roles}})")
  end

  def destroy
    mongo(@resource[:database], '--quiet', '--host', @resource[:router], '--eval', "db.dropUser(\"#{@resource[:name]}\")")
  end

  def exists?
    block_until_mongodb
    if !self.db_ismaster(@resource[:router])
      warn ('Cannot add user on not primary/master member!')
      return true
    end
    mongo('admin', '--quiet', '--host', @resource[:router], '--eval', "db.system.users.find({user:\"#{@resource[:name]}\", db: \"#{@resource[:database]}\"}).count()").strip.eql?('1')
  end

  def password_hash
    if !self.db_ismaster(@resource[:router])
      return @resource[:password_hash]
    end
    mongo('admin', '--quiet', '--host', @resource[:router], '--eval', "db.system.users.findOne({user:\"#{@resource[:name]}\", db: \"#{@resource[:database]}\"})[\"pwd\"]").strip
  end

  def password_hash=(value)
    mongo('admin', '--quiet', '--host', @resource[:router], '--eval', "db.system.users.update({user:\"#{@resource[:name]}\", db: \"#{@resource[:database]}\"}, { $set: {pwd:\"#{value}\"}})")
  end

  def roles
    if !self.db_ismaster(@resource[:router])
      return @resource[:roles]
    end
    user = self.mongo_command("db.getMongo().getDB('admin').getCollection('system.users').findOne({user:\"#{@resource[:name]}\", db: \"#{@resource[:database]}\"})", @resource[:router])
    user['roles']
  end

  def roles=(value)
    roles = JSON.dump @resource[:roles]
    mongo('admin', '--quiet', '--host', @resource[:router], '--eval', "db.system.users.update({user:\"#{@resource[:name]}\", db: \"#{@resource[:database]}\"}, { $set: {roles: #{roles}}})")
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

  def db_ismaster(host)
    status = self.mongo_command("db.isMaster()", host)
    status['ismaster'] == true
  end

end
