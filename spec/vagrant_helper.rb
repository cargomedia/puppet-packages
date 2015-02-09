require 'open3'
require 'net/ssh'
require 'tempfile'

class VagrantHelper

  def initialize(working_dir, box, verbose)
    @working_dir = working_dir
    @box = box
    @verbose = verbose
  end

  def reset
    unless execute_local('vagrant plugin list').match(/vagrant-vbox-snapshot/)
      execute_local('vagrant plugin install vagrant-vbox-snapshot')
    end

    if status == 'not created'
      has_snapshot = false
    else
      has_snapshot = execute_local("vagrant snapshot list #{@box}").match(/Name: default /)
    end

    if has_snapshot
      execute_local("vagrant snapshot go #{@box} default")
    else
      execute_local("vagrant destroy -f #{@box}")
      execute_local("vagrant up --no-provision #{@box}", {'DISABLE_PROXY' => 'true'})
      execute_local("vagrant provision #{@box}", {'DISABLE_PROXY' => 'true'})
      execute_local("vagrant provision #{@box}")
      execute_local("vagrant snapshot take #{@box} default")
    end
  end

  def status
    output = execute_local("vagrant status #{@box}")
    match_data = /^#{@box}\s+(.+?)\s+\(.+?\)$/.match(output)
    if match_data.nil?
      raise "Cannot detect machine status from output: `#{output}`."
    end
    match_data[1]
  end

  def ssh_options
    unless @options
      config = Tempfile.new('')
      execute_local("vagrant ssh-config > #{config.path}")
      @options = Net::SSH::Config.for(@box, [config.path])
    end
    @options
  end

  def execute_ssh(command)
    options = ssh_options
    @connection = Net::SSH.start(options[:host_name], options[:user], options) unless @connection
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

    output_stdout = output_stderr = exit_code = nil
    Dir.chdir(@working_dir) {
      Open3.popen3(ENV.to_hash.merge(env), command) { |stdin, stdout, stderr, wait_thr|
        output_stdout = stdout.read.chomp
        output_stderr = stderr.read.chomp
        exit_code = wait_thr.value
      }
    }

    unless exit_code.success?
      message = ['Command execution failed:', command]
      message.push 'STDOUT:', output_stdout unless output_stdout.empty?
      message.push 'STDERR:', output_stderr unless output_stderr.empty?
      raise message.join("\n")
    end

    output_stdout
  end

  def get_path(real_path)
    real_path.sub(@working_dir, '/vagrant')
  end
end
