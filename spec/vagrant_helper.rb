class VagrantHelper

  def initialize(working_dir, verbose)
    @working_dir = working_dir
    @verbose = verbose
  end

  def command(subcommand)
    puts 'Vagrant: ' + subcommand if @verbose
    `cd #{@working_dir} && vagrant #{subcommand}`
  end

  def is_running?
    command('status').match(/running/)
  end

  def reset
    has_snapshot = system('vagrant snapshot list 2>/dev/null | grep -q "Name: default "')

    actions = []
    unless has_snapshot
      actions.push('destroy -f')
      actions.push('up')
      actions.push('snapshot take default')
    end


    unless is_running?
      actions.push('up')
    end
    actions.push('snapshot go default')
    #actions.push('provision')
    actions.push("ssh -c 'sudo umount /var/cache/polipo;sudo mount 10.10.20.1:#{@working_dir}/var/cache/polipo /var/cache/polipo;'")
=begin

    actions.push("ssh -c '/etc/init.d/polipo restart'")
=end

    actions.each do |action|
      command action
    end
  end

  def connect
    user = Etc.getlogin
    options = {}
    host = ''
    config = command 'ssh-config'
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

  def exec(command)
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

  def get_path(real_path)
    real_path.sub(@working_dir, '/vagrant')
  end
end
