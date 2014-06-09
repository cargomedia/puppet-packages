class Puppet::Provider::Mongodb < Puppet::Provider

  def block_until_mongodb(host = @resource[:router], tries = 10, command = '{}')
    check = lambda {
      data = self.mongo_command(command, host)
      if data.has_key?('ok') and data['ok'] == 0
        raise("Result's `ok` is `#{data['ok']}`")
      end
    }
    block_until(check, tries)
  end

  def block_until(check, tries = 10)
    begin
      check.call
    rescue => e
      debug("MongoDB server not ready (#{e.message}), retrying...")
      sleep 2
      raise("Cannot connect to MongoDB router instance (#{e.message})") if (tries -= 1) <= 0
      retry
    end
  end

  def mongo_command(command, host)
    output = self.mongo('--quiet', '--host', host, '--eval', "printjson(#{command})")

    # Dirty hack to remove JavaScript objects
    output.gsub!(/ISODate\((.+?)\)/, '\1 ')
    output.gsub!(/Timestamp\((.+?)\)/, '[\1]')
    output.gsub!(/ObjectId\((.+?)\)/, '1')

    JSON.parse(output)
  end

end
