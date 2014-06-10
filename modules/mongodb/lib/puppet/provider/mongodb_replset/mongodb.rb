require 'puppet/provider/mongodb'

Puppet::Type.type(:mongodb_replset).provide :mongodb, :parent => Puppet::Provider::Mongodb do

  desc "Manage hosts members for a replicaset."

  commands :mongo => 'mongo'

  def create
    config_members = members_all_alive.each_with_index.map do |host, id|
      is_arbiter = @resource[:arbiters].include?(host)
      {'_id' => id, 'host' => host, 'arbiterOnly' => is_arbiter}
    end

    config_members_non_arbiter = config_members.select { |host| !host['arbiterOnly'] }
    if 0 == config_members_non_arbiter.count
      raise Puppet::Error, 'Cannot initialize replica-set without alive non-arbiter nodes'
    end

    member_execution = config_members_non_arbiter.first['host']

    rs_initiate({'_id' => @resource[:name], 'members' => config_members}, member_execution)

    block_until(lambda {
      if find_member_primary(member_execution).nil?
        raise "No primary detected for replica `#{@resource[:name]}`"
      end
    })
  end

  def destroy
    raise Puppet::Error, 'Not implemented'
  end

  def exists?
    # not enough, check if replica is initiated
    !find_member_primary.nil?
  end

  def members
    master = find_member_primary
    if master.nil?
      raise Puppet::Error, "Can't find master host for replicaset #{@resource[:name]}."
    end
    find_members(master) - @resource[:arbiters]
  end

  def members=(hosts)
    master = find_member_primary
    if master.nil?
      raise Puppet::Error, "Can't find master host for replicaset #{@resource[:name]}."
    end
    hosts_current = find_members(master) - @resource[:arbiters]
    (hosts - hosts_current).each do |host|
      rs_add(host, master)
    end
    (hosts_current - hosts).each do |host|
      rs_remove(host, master)
    end
  end

  def arbiters
    master = find_member_primary
    if master.nil?
      raise Puppet::Error, "Can't find master host for replicaset #{@resource[:name]}."
    end
    find_members(master) - @resource[:members]
  end

  def arbiters=(hosts)
    master = find_member_primary
    if master.nil?
      raise Puppet::Error, "Can't find master host for replicaset #{@resource[:name]}."
    end
    hosts_current = find_members(master) - @resource[:members]
    (hosts - hosts_current).each do |host|
      rs_add_arbiter(host, master)
    end
    (hosts_current - hosts).each do |host|
      rs_remove(host, master)
    end
  end

  private

  def members_all
    @resource[:members] + @resource[:arbiters]
  end

  def members_all_alive
    members_all.select do |host|
      begin
        mongo_command('db.getMongo()', host)
        true
      rescue Puppet::ExecutionFailure
        false
      end
    end
  end

  def find_members(host_to_ask)
    rs_status(host_to_ask)['members'].map { |member| member['name'] }
  end

  def find_member_primary(host_to_ask = nil)
    find_member('PRIMARY', host_to_ask)
  end

  def find_member_secondary(host_to_ask = nil)
    find_member('SECONDARY', host_to_ask)
  end

  def find_member(state_str, host_to_ask = nil)
    members_to_ask = host_to_ask ? [host_to_ask] : members_all
    members_to_ask.each do |host|
      begin
        members_primary = rs_status(host)['members'].select { |member| state_str == member['stateStr'] }
      rescue
        next
      end
      if members_primary.length > 0
        return members_primary.first['name']
      end
    end
    nil
  end

  def rs_initiate(conf, host)
    output = mongo_command_json("rs.initiate(#{JSON.dump(conf)})", host)
    if output['ok'] == 0
      raise Puppet::Error, "rs.initiate() failed for replicaset #{@resource[:name]}: #{output['errmsg']}"
    end
  end

  def rs_status(host)
    status = mongo_command_json('rs.status()', host)
    if status['set'] != @resource[:name]
      raise Puppet::Error, "Host `#{host}` is part of replica set `#{status['set']}` instead of `#{@resource[:name]}`."
    end
    status
  end

  def rs_add(host, master, arbiter_only = false)
    output = mongo_command_json("rs.add(#{JSON.dump host}, #{JSON.dump arbiter_only})", master)
    if output['ok'] == 0
      raise Puppet::Error, "rs.add() failed for host #{host} in replicaset #{@resource[:name]}: #{output['errmsg']}"
    end
  end

  def rs_add_arbiter(host, master)
    rs_add(host, master, true)
  end

  def rs_remove(host, master)
    if host == master
      begin
        block_until(lambda {
          secondary = find_member_secondary
          if secondary.nil?
            raise "No secondary detected for replica `#{@resource[:name]}`"
          end
        })

        mongo_command('rs.stepDown(60)', host)
        # "shutdownServer failed: no secondaries within 10 seconds of my optime"
        mongo_command('db.shutdownServer({timeoutSecs : 30, force: 1})', host, 'admin')

        block_until(lambda {
          primary = find_member_primary()
          if primary.nil? or primary == host
            raise "No new primary detected for replica `#{@resource[:name]}`"
          end
          master = primary
        })
      rescue => e
        raise Puppet::Error, "rs.stepDown() failed for host #{host} in replicaset #{@resource[:name]}: #{e.message}"
      end
    else
      mongo_command('db.shutdownServer()', host, 'admin') if @resource[:members].include?(host)
    end

    begin
      output = mongo_command_json("rs.remove(#{JSON.dump host})", master)
      raise Puppet::Error, "rs.remove() failed for host #{host} in replicaset #{@resource[:name]}: #{output['errmsg']}"
    rescue
      # all went good. mongo client should be disconnected!
    end
  end

end
