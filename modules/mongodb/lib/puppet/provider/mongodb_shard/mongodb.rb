require 'puppet/provider/mongodb'

Puppet::Type.type(:mongodb_shard).provide :mongodb, :parent => Puppet::Provider::Mongodb do

  desc 'Manage shards for a MongoDB cluster.'

  defaultfor :kernel => 'Linux'

  def create
    repl_set = ''
    unless @resource[:repl_set].to_s.empty?
      repl_set = @resource[:repl_set] + '/'
    end
    sh_add("#{repl_set}#{@resource[:name]}", @resource[:router])
  end

  def destroy
    raise Puppet::Error, 'Not implemented'
  end

  def exists?
    block_until_command @resource[:name]
    block_until_command @resource[:router]
    sh_isshard(@resource[:name], @resource[:router])
  end

  private

  def sh_isshard(host, router)
    output = mongo_command("db.shards.find({\"host\": /#{host}/}).count()", router, 'config')
    output.to_i > 0
  end

  def sh_add(host, router)
    output = self.mongo_command_json("sh.addShard(#{JSON.dump(host)})", router)
    if output['ok'] == 0
      raise Puppet::Error, "sh.addShard() failed for #{@resource[:name]}: #{output['errmsg']}"
    end
  end

end
