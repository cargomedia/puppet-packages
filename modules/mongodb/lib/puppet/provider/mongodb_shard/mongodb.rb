require 'puppet/provider/mongodb'

Puppet::Type.type(:mongodb_shard).provide :mongodb, :parent => Puppet::Provider::Mongodb do

  desc "Manage shards for a MongoDB cluster."

  defaultfor :kernel => 'Linux'

  commands :mongo => 'mongo'

  def create
    repl_set = ''
    if !@resource[:repl_set].to_s.empty?
      repl_set = @resource[:repl_set] + '/'
    end
    sh_add("#{repl_set}#{@resource[:name]}", @resource[:router])
  end

  def destroy
    raise('Not implemented')
  end

  def exists?
    block_until_mongodb @resource[:name]
    block_until_mongodb @resource[:router]
    sh_isshard(@resource[:name], @resource[:router])
  end

  def sh_isshard(host, master)
    output = self.mongo('config', '--quiet', '--host', master, '--eval', "printjson(db.shards.find({\"host\": /#{host}/}).count())")
    output.to_i > 0
  end

  def sh_add(host, master)
    self.mongo_command("sh.addShard(\"#{host}\")", master)
  end

end
