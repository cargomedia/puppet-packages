require 'puppet/provider/mongodb'

Puppet::Type.type(:mongodb_database).provide :mongodb, :parent => Puppet::Provider::Mongodb do

  desc 'Manages MongoDB database.'

  defaultfor :kernel => 'Linux'

  def create
    mongo_command('db.dummyData.insert({"created_by_puppet": 1})', @resource[:router], @resource[:name])
    if :true == resource.should(:shard)
      sh_enable(@resource[:name], @resource[:router])
    end
  end

  def destroy
    raise Puppet::Error, 'Not implemented'
  end

  def exists?
    block_until_command
    unless db_ismaster_info(@resource[:router])['ismaster']
      raise Puppet::Error, "Cannot add database `#{@resource[:name]}` on non-primary `#{@resource[:router]}`"
    end

    mongo_command_json('db.getMongo().getDBNames()', @resource[:router]).include?(@resource[:name])
  end

  def shard
    issharded = sh_issharded(@resource[:name], @resource[:router])
    issharded ? :true : :false
  end

  def shard=(value)
    if :true == value
      sh_enable(@resource[:name], @resource[:router])
    else
      raise Puppet::Error, "Cannot disable sharding for database `#{@resource[:name]}`"
    end
  end

  private

  def sh_enable(dbname, master)
    self.mongo_command_json("sh.enableSharding('#{dbname}')", master)
  end

  def sh_issharded(dbname, master)
    output = mongo_command("db.databases.find({\"_id\": \"#{dbname}\", \"partitioned\": true}).count()", master, 'config')
    1 == output.to_i
  end

  def db_ismaster_info(host)
    mongo_command_json('db.isMaster()', host)
  end

end
