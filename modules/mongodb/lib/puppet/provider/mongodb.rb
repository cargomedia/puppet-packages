class Puppet::Provider::Mongodb < Puppet::Provider

  def block_until_command(host = @resource[:router], seconds = 30, command = '{}')
    check = lambda {
      data = self.mongo_command_json(command, host)
      if data.has_key?('ok') and data['ok'] == 0
        raise("Result's `ok` is `#{data['ok']}`")
      end
    }
    block_until(check, seconds)
  end

  def block_until(check, seconds = 30)
    delay = 2
    begin
      check.call
    rescue => e
      debug("MongoDB server not ready (#{e.message}), retrying...")
      sleep delay
      raise("Cannot connect to MongoDB router instance (#{e.message})") if (seconds -= delay) <= 0
      retry
    end
  end

  def mongo_command_json(command, host, database = nil, options = {})
    output = self.mongo_command("printjson(#{command})", host, database, options).strip

    if 'null' == output
      return nil
    end

    # Dirty hack to remove JavaScript objects
    output.gsub!(/ISODate\((.+?)\)/, '\1 ')
    output.gsub!(/Timestamp\((.+?)\)/, '[\1]')
    output.gsub!(/ObjectId\((.+?)\)/, '1')

    JSON.parse(output)
  end

  def mongo_command(command, host, database = nil, options = {})
    defaults = {:skip_fail => false}
    options = defaults.merge(options)

    mongorc_path = options[:mongorc_path] || '/etc/mongorc.js'
    pre_command = File.exist?(mongorc_path) ? "load('#{mongorc_path}');" : ''

    args = ['--quiet', '--host', host, '--eval', "#{pre_command}#{command}"]
    unless database.nil?
      args.unshift(database)
    end

    command_options = {:failonfail => !options[:skip_fail], :combine => true, :custom_environment => {}}
    command = Puppet::Provider::Command.new('mongo', 'mongo', Puppet::Util, Puppet::Util::Execution, command_options)
    command.execute(*args)
  end

end
