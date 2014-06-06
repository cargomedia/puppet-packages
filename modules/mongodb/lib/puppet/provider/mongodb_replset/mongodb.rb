require 'puppet/provider/mongodb'

Puppet::Type.type(:mongodb_replset).provide :mongodb, :parent => Puppet::Provider::Mongodb do

  desc "Manage hosts members for a replicaset."

  commands :mongo => 'mongo'

  def create
    if @resource[:arbiter]
      if master = master_host
        self.rs_addArb(@resource[:arbiter], master)
      end
    else
      alive_members = members_present
      hostsconf = alive_members.each_with_index.map do |host, id|
        "{ _id: #{id}, host: \"#{host}\" }"
      end.join(',')
      conf = "{ _id: \"#{@resource[:name]}\", members: [ #{hostsconf} ] }"
      output = self.rs_initiate(conf, alive_members[0])
      if output['ok'] == 0
        raise Puppet::Error, "rs.initiate() failed for replicaset #{@resource[:name]}: #{output['errmsg']}"
      end
    end
  end

  def destroy
  end

  def exists?
    failcount = 0
    is_configured = false
    @resource[:members].each do |host|
      begin
        block_until_mongodb host
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

    if @resource[:arbiter]
      is_configured = false
      if master = master_host()
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
    if master = self.master_host()
      self.db_ismaster(master)['hosts']
    else
      raise Puppet::Error, "Can't find master host for replicaset #{@resource[:name]}."
    end
  end

  def members=(hosts)
    if master = master_host()
      current = self.db_ismaster(master)['hosts']
      newhosts = hosts - current
      newhosts.each do |host|
        #TODO: check output (['ok'] == 0 should be sufficient)
        self.rs_add(host, master)
      end
    else
      raise Puppet::Error, "Can't find master host for replicaset #{@resource[:name]}."
    end
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

  def db_ismaster(host)
    self.mongo_command("db.isMaster()", host)
  end

  def rs_initiate(conf, host)
    return self.mongo_command("rs.initiate(#{conf})", host)
  end

  def rs_status(host)
    self.mongo_command("rs.status()", host)
  end

  def rs_add(host, master)
    self.mongo_command("rs.add(\"#{host}\")", master)
  end

  def rs_addArb(host, master)
    self.mongo_command("rs.addArb(\"#{host}\")", master)
  end

  def rs_remove(host, master)
    self.mongo_command("rs.remove(\"#{host}\")", master)
  end

end
