require 'puppet/provider/mongodb'

Puppet::Type.type(:mongodb_replset).provide :mongodb, :parent => Puppet::Provider::Mongodb do

  desc "Manage hosts members for a replicaset."

  commands :mongo => 'mongo'

  def create
    config_members = members_all_alive.each_with_index.map do |host, id|
      is_arbiter = (host == @resource[:arbiter])
      {'_id' => id, 'host' => host, 'arbiterOnly' => is_arbiter}
    end

    config_members_non_arbiter = config_members.select { |host| !host['arbiterOnly'] }
    if 0 == config_members_non_arbiter.count
      raise Puppet::Error, 'Cannot initialize replica-set without alive non-arbiter nodes'
    end

    member_execution = config_members_non_arbiter.first['host']

    self.rs_initiate({'_id' => @resource[:name], 'members' => config_members}, member_execution)

    block_until(lambda {
      if member_primary(member_execution).nil?
        raise "No primary detected for replica `#{@resource[:name]}`"
      end
    })
  end

  def destroy
    raise Puppet::Error, 'Not implemented'
  end

  def exists?
    !member_primary.nil?
  end

  def members
    master = self.member_primary
    if master.nil?
      raise Puppet::Error, "Can't find master host for replicaset #{@resource[:name]}."
    end
    rs_status(master)['members'].map { |member| member['name'] }
  end

  def members=(hosts)
    master = self.member_primary
    if master.nil?
      raise Puppet::Error, "Can't find master host for replicaset #{@resource[:name]}."
    end
    hosts_current = members
    (hosts - hosts_current).each do |host|
      if host == @resource[:arbiter]
        self.rs_addArb(host, master)
      else
        self.rs_add(host, master)
      end
    end
    (hosts_current - hosts).each do |host|
      # @todo remove host
    end
  end

  private

  def members_all
    members = @resource[:members]
    members += @resource[:arbiter] unless @resource[:arbiter].nil?
    members
  end

  def members_all_alive
    members_all.select do |host|
      begin
        self.mongo_command('db.getMongo()', host)
        true
      rescue Puppet::ExecutionFailure
        false
      end
    end
  end

  def member_primary(host = nil)
    members_to_ask = host ? [host] : members_all
    members_to_ask.each do |h|
      begin
        members_primary = rs_status(h)['members'].select { |member| 'PRIMARY' == member['stateStr'] }
        if members_primary.count?
          return members_primary.first
        end
      rescue
        # do nothing
      end
    end
    nil
  end

  def rs_initiate(conf, host)
    output = self.mongo_command_json("rs.initiate(#{JSON.dump(conf)})", host)
    if output['ok'] == 0
      raise Puppet::Error, "rs.initiate() failed for replicaset #{@resource[:name]}: #{output['errmsg']}"
    end
  end

  def rs_status(host)
    status = self.mongo_command_json('rs.status()', host)
    if status['set'] != @resource[:name]
      raise Puppet::Error, "Host `#{host}` is part of replica set `#{status['set']}` instead of `#{@resource[:name]}`."
    end
    status
  end

  def rs_add(host, master)
    self.mongo_command_json("rs.add(\"#{host}\")", master)
  end

  def rs_addArb(host, master)
    self.mongo_command_json("rs.addArb(\"#{host}\")", master)
  end

  def rs_remove(host, master)
    self.mongo_command_json("rs.remove(\"#{host}\")", master)
  end

end
