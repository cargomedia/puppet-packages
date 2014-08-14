class VagrantHelper

  def initialize(working_dir, box, verbose)
    @working_dir = working_dir
    @box = box
    @verbose = verbose
  end

  def reset
    has_snapshot = execute_local("vagrant snapshot list #{@box} 2>/dev/null | grep -q 'Name: default '")
    is_running = execute_local("vagrant status #{@box}").match(/running/)

    unless has_snapshot
      execute_local("vagrant destroy -f #{@box}")
      execute_local("vagrant up --no-provision #{@box}", {'DISABLE_PROXY' => 'true'})
      execute_local("vagrant provision #{@box}", {'DISABLE_PROXY' => 'true'})
      execute_local("vagrant provision")
      execute_local("vagrant snapshot take #{@box} default")
    end
    unless is_running
      execute_local("vagrant up #{@box}")
    end
    execute_local("vagrant snapshot go #{@box} default")
  end

  def connect
    user = Etc.getlogin
    options = {}
    host = ''
    config = execute_local("vagrant ssh-config #{@box}")
    config.each_line do |line|
      if match = /HostName (.*)/.match(line)
        host = match[1]
        options = Net::SSH::Config.for(host)
      elsif  match = /User (.*)/.match(line)
        user = match[1]
      elsif match = /IdentityFile (.*)/.match(line)
        options[:keys] = [match[1].gsub(/"/, '')]
      elsif match = /Port (.*)/.match(line)
        options[:port] = match[1]
      end
    end
    @connection = Net::SSH.start(host, user, options)
  end

  def execute_ssh(command)
    channel = @connection.open_channel do |channel|
      channel.exec(command) do |ch, success|
        raise "could not execute command: #{command.inspect}" unless success
        ch[:output] = ''

        channel.on_data do |ch2, data|
          puts data if @verbose
          ch[:output] << data
        end

        channel.on_extended_data do |ch2, type, data|
          puts data if @verbose
          ch[:output] << data
        end

        channel.on_request "exit-status" do |ch, data|
          ch[:success] = (data.read_long == 0)
        end
      end
    end
    channel.wait
    raise channel[:output] unless channel[:success]
    channel[:output]
  end

  def execute_local(command, env = {})
    if @verbose
      puts command + (env.length > 0 ? ' (' + env.to_s + ')' : '')
    end
    env_backup = ENV.to_hash
    env.each { |key, value| ENV[key] = value }
    output = `cd #{@working_dir} && #{command}`
    ENV.replace(env_backup)
    output
  end

  def get_path(real_path)
    real_path.sub(@working_dir, '/vagrant')
  end
end
