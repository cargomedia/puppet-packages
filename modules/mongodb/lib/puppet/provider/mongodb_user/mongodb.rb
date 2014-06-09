require 'puppet/provider/mongodb'

Puppet::Type.type(:mongodb_user).provide :mongodb, :parent => Puppet::Provider::Mongodb do

  desc "Manage users for a MongoDB database."

  defaultfor :kernel => 'Linux'

  commands :mongo => 'mongo'

  def create
    roles = JSON.dump @resource[:roles]
    mongo(@resource[:database], '--host', @resource[:router], '--eval', "db.createUser({user:\"#{@resource[:name]}\", pwd:\"#{@resource[:password_hash]}\", roles: #{roles}})")
  end

  def destroy
    mongo(@resource[:database], '--quiet', '--host', @resource[:router], '--eval', "db.dropUser(\"#{@resource[:name]}\")")
  end

  def exists?
    block_until_command
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
    user = self.mongo_command_json("db.getMongo().getDB('admin').getCollection('system.users').findOne({user:\"#{@resource[:name]}\", db: \"#{@resource[:database]}\"})", @resource[:router])
    user['roles']
  end

  def roles=(value)
    roles = JSON.dump @resource[:roles]
    mongo('admin', '--quiet', '--host', @resource[:router], '--eval', "db.system.users.update({user:\"#{@resource[:name]}\", db: \"#{@resource[:database]}\"}, { $set: {roles: #{roles}}})")
  end

  def db_ismaster(host)
    status = self.mongo_command_json("db.isMaster()", host)
    status['ismaster'] == true
  end

end
