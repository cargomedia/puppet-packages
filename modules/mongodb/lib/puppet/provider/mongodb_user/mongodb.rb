require 'puppet/provider/mongodb'

Puppet::Type.type(:mongodb_user).provide :mongodb, :parent => Puppet::Provider::Mongodb do

  desc "Manage users for a MongoDB database."

  defaultfor :kernel => 'Linux'

  def create
    roles = JSON.dump @resource[:roles]
    mongo_command("db.createUser({user:\"#{@resource[:name]}\", pwd:\"#{@resource[:password_hash]}\", roles: #{roles}})", @resource[:router], @resource[:database])
  end

  def destroy
    mongo_command("db.dropUser(\"#{@resource[:name]}\")", @resource[:router], @resource[:database])
  end

  def exists?
    block_until_command
    if !self.db_ismaster(@resource[:router])
      warn ('Cannot add user on not primary/master member!')
      return true
    end
    output = mongo_command("db.system.users.find({user:\"#{@resource[:name]}\", db: \"#{@resource[:database]}\"}).count()", @resource[:router], 'admin')
    1 == output.to_i
  end

  def password_hash
    if !self.db_ismaster(@resource[:router])
      return @resource[:password_hash]
    end
    user = mongo_command_json("db.system.users.findOne({user:\"#{@resource[:name]}\", db: \"#{@resource[:database]}\"})", @resource[:router], 'admin')
    user['pwd']
  end

  def password_hash=(value)
    mongo_command("db.system.users.update({user:\"#{@resource[:name]}\", db: \"#{@resource[:database]}\"}, { $set: {pwd:\"#{value}\"}})", @resource[:router], 'admin')
  end

  def roles
    if !self.db_ismaster(@resource[:router])
      return @resource[:roles]
    end
    user = mongo_command_json("db.getMongo().getDB('admin').getCollection('system.users').findOne({user:\"#{@resource[:name]}\", db: \"#{@resource[:database]}\"})", @resource[:router])
    user['roles']
  end

  def roles=(value)
    roles = JSON.dump @resource[:roles]
    mongo_command("db.system.users.update({user:\"#{@resource[:name]}\", db: \"#{@resource[:database]}\"}, { $set: {roles: #{roles}}})", @resource[:router])
  end

  def db_ismaster(host)
    status = mongo_command_json("db.isMaster()", host)
    status['ismaster'] == true
  end

end
