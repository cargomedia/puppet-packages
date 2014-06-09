require 'puppet/provider/mongodb'

Puppet::Type.type(:mongodb_replset).provide :mongodb, :parent => Puppet::Provider::Mongodb do

  desc "Manage hosts members for a replicaset."

  commands :mongo => 'mongo'

  def create
    return true if master_host

    alive_members = members_present
    members = alive_members.each_with_index.map do |host, id|
      is_arbiter = (host == @resource[:arbiter])
      {'_id' => id, 'host' => host, 'arbiterOnly' => is_arbiter}
    end

    members_non_arbiter = members.select { |host| !host['arbiterOnly'] }

    if 0 == members_non_arbiter.count
      raise Puppet::Error, 'Cannot initialize replica-set without alive non-arbiter nodes'
    end

    output = self.rs_initiate({'_id' => @resource[:name], 'members' => members}, members_non_arbiter.first['host'])
    if output['ok'] == 0
      raise Puppet::Error, "rs.initiate() failed for replicaset #{@resource[:name]}: #{output['errmsg']}"
    end

    block_until(lambda {
      status = mongo_command_json('db.isMaster()', members_non_arbiter.first['host'])
      unless status.has_key?('primary')
        raise "No primary detected for replica `#{@resource[:name]}`"
      end
    })
  end

  def destroy
    raise('Not implemented')
  end

  def exists?
    failcount = 0
    is_configured = false
    @resource[:members].each do |host|
      begin
        block_until_command host
        debug "Checking replicaset member #{host} ..."
        status = self.rs_status(host)
        if status.has_key?('errmsg') and status['errmsg'] == 'not running with --replSet'
          raise Puppet::Error, "Can't configure replicaset #{@resource[:name]}, host #{host} is not supposed to be part of a replicaset."
        end
        if status.has_key?('set')
          if status['set'] != @resource[:name]
            raise Puppet::Error, "Can't configure replicaset #{@resource[:name]}, host #{host} is already part of another replicaset."
          end
          is_configured = true
        end
      rescue Puppet::ExecutionFailure
        debug "Can't connect to replicaset member #{host}."
        failcount += 1
      end
    end

    unless @resource[:arbiter].empty?
      is_configured = false
      if master = master_host
        status = self.rs_status(master)
        if status.has_key?('members')
          status['members'].each do |host|
            if host['stateStr'] == 'ARBITER' and host['name'] == @resource[:arbiter]
              is_configured = true
            elsif host['name'] == @resource[:arbiter]
              self.rs_remove(@resource[:arbiter], master)
            end
          end
        end
      end
    end

    if failcount == @resource[:members].length
      raise Puppet::Error, "Can't connect to any member of replicaset #{@resource[:name]}."
    end

    return is_configured
  end

  def members
    if master = self.master_host
      db = self.db_ismaster(master)
      members = db['hosts']
      members += db['arbiters'] if db.has_key?('arbiters')
    else
      raise Puppet::Error, "Can't find master host for replicaset #{@resource[:name]}."
    end
    members
  end

  def members=(hosts)
    add_members hosts
  end

  def members_present
    @resource[:members].select do |host|
      begin
        self.mongo('--host', host, '--quiet', '--eval', 'db.version()')
        true
      rescue Puppet::ExecutionFailure
        false
      end
    end
  end

  def master_host
    @resource[:members].each do |host|
      begin
        status = self.db_ismaster(host)
        if status.has_key?('primary')
          return status['primary']
        end
      rescue
        # do nothing
      end
    end
    false
  end

  def add_members(hosts)
    if master = master_host()
      current = self.db_ismaster(master)['hosts']
      newhosts = hosts - current
      newhosts.each do |host|
        puts host, @resource[:arbiter]
        if host == @resource[:arbiter]
          self.rs_addArb(host, master)
        else
          self.rs_add(host, master)
        end
      end
    else
      raise Puppet::Error, "Can't find master host for replicaset #{@resource[:name]}."
    end
  end

  def db_ismaster(host)
    self.mongo_command_json("db.isMaster()", host)
  end

  def rs_initiate(conf, host)
    return self.mongo_command_json("rs.initiate(#{JSON.dump(conf)})", host)
  end

  def rs_status(host)
    self.mongo_command_json("rs.status()", host)
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
