require 'puppet/provider/mongodb'

Puppet::Type.type(:mongodb_user).provide :mongodb, :parent => Puppet::Provider::Mongodb do

  desc 'Manage users for a MongoDB database.'

  defaultfor :kernel => 'Linux'

  def create
    password_hash = create_password_hash('puppet-mongodb', @resource[:password])
    data = {
        :user => @resource[:name],
        :pwd => @resource[:password],
        :roles => @resource[:roles],
        :customData => {:puppetPasswordHash => password_hash}
    }
    mongo_command("db.createUser(#{JSON.dump data})", @resource[:router], @resource[:database])
  end

  def destroy
    mongo_command("db.dropUser(#{JSON.dump @resource[:name]})", @resource[:router], @resource[:database])
  end

  def exists?
    block_until_command
    unless db_ismaster(@resource[:router])['ismaster']
      raise Puppet::Error, 'Cannot add user on not primary/master member!'
    end
    !db_find_user.nil?
  end

  def password
    password_hash_should = create_password_hash('puppet-mongodb', @resource[:password])
    password_hash_is = db_find_user['customData']['puppetPasswordHash']
    if password_hash_is == password_hash_should
      @resource[:password]
    else
      @resource[:password] + 'change_me'
    end
  end

  def password=(value)
    password_hash = create_password_hash('puppet-mongodb', value)
    db_update_user({:pwd => value, :customData => {:puppetPasswordHash => password_hash}})
  end

  def roles
    db_find_user['roles']
  end

  def roles=(value)
    db_update_user({:roles => value})
  end

  private

  def db_ismaster(host)
    mongo_command_json("db.isMaster()", host)
  end

  def db_find_user
    mongo_command_json("db.getUser(\"#{@resource[:name]}\")", @resource[:router], @resource[:database])
  end

  def db_update_user(data)
    mongo_command("db.updateUser(#{JSON.dump @resource[:name]}, #{JSON.dump data})", @resource[:router], @resource[:database])
  end

  def create_password_hash(password, salt)
    Digest::MD5.hexdigest("#{salt}:mongo:#{password}")
  end

end
