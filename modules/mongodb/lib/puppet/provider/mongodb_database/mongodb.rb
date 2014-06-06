require 'puppet/provider/mongodb'

Puppet::Type.type(:mongodb_database).provide :mongodb, :parent => Puppet::Provider::Mongodb do

  desc "Manages MongoDB database."

  defaultfor :kernel => 'Linux'

  commands :mongo => 'mongo'

  def create
    mongo(@resource[:name], '--quiet', '--host', @resource[:router], '--eval', "db.dummyData.insert({\"created_by_puppet\": 1})")
    if @resource[:shard] and !self.sh_issharded(@resource[:name], @resource[:router])
      self.sh_enable(@resource[:name], @resource[:router])
    end
  end

  def destroy
    mongo(@resource[:name], '--quiet', '--host', @resource[:router], '--eval', 'db.dropDatabase()')
  end

  def exists?
    block_until_mongodb
    if !self.db_ismaster(@resource[:router])
      warn ('Cannot add database on not primary/master member!')
      return true
    end

    db_exists = mongo('--quiet', '--host', @resource[:router], '--eval', 'db.getMongo().getDBNames()').split(",").include?(@resource[:name])
    if @resource[:ensure].to_s != 'absent' and @resource[:shard] and db_exists
      return self.sh_issharded(@resource[:name], @resource[:router])
    end
    db_exists
  end

  def sh_enable(dbname, master)
    self.mongo_command("sh.enableSharding('#{dbname}')", master)
  end

  def sh_issharded(dbname, master)
    output = self.mongo('config', '--quiet', '--host', master, '--eval', "printjson(db.databases.find({\"_id\": \"#{dbname}\", \"partitioned\": true}).count())")
    1 == output.to_i
  end

  def db_ismaster(host)
    status = self.mongo_command("db.isMaster()", host)
    status['ismaster'] == true
  end

end
