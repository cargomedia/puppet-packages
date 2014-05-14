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
    mongo(@resource[:database], '--eval', "db.system.users.insert({user:\"#{@resource[:name]}\", pwd:\"#{@resource[:password_hash]}\", roles: #{@resource[:roles].inspect}})")
  end

  def destroy
    mongo(@resource[:database], '--quiet', '--eval', "db.removeUser(\"#{@resource[:name]}\")")
  end

  def exists?
    block_until_mongodb(@resource[:tries])
    mongo(@resource[:database], '--quiet', '--eval', "db.system.users.find({user:\"#{@resource[:name]}\"}).count()").strip.eql?('1')
  end

end
