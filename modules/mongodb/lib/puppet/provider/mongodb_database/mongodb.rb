require 'puppet/provider/mongodb'

Puppet::Type.type(:mongodb_database).provide :mongodb, :parent => Puppet::Provider::Mongodb do

  desc "Manages MongoDB database."

  defaultfor :kernel => 'Linux'

  def create
    mongo_command('db.dummyData.insert({"created_by_puppet": 1})', @resource[:router], @resource[:name])
    if @resource[:shard] and !self.sh_issharded(@resource[:name], @resource[:router])
      self.sh_enable(@resource[:name], @resource[:router])
    end
  end

  def destroy
    mongo_command('db.dropDatabase()', @resource[:router], @resource[:name])
  end

  def exists?
    block_until_command
    if !self.db_ismaster(@resource[:router])
      warn ('Cannot add database on not primary/master member!')
      return true
    end

    db_exists = mongo_command('db.getMongo().getDBNames()', @resource[:router]).split(",").include?(@resource[:name])
    if @resource[:ensure].to_s != 'absent' and @resource[:shard] and db_exists
      return self.sh_issharded(@resource[:name], @resource[:router])
    end
    db_exists
  end

  def sh_enable(dbname, master)
    self.mongo_command_json("sh.enableSharding('#{dbname}')", master)
  end

  def sh_issharded(dbname, master)
    output = mongo_command("db.databases.find({\"_id\": \"#{dbname}\", \"partitioned\": true}.count()", master, 'config')
    1 == output.to_i
  end

  def db_ismaster(host)
    status = self.mongo_command_json("db.isMaster()", host)
    status['ismaster'] == true
  end

end
