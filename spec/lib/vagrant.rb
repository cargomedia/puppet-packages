require 'open3'
require 'net/ssh'
require 'tempfile'
require 'pathname'
require 'komenda'

class Vagrant

  attr_reader :working_dir

  # @param [Pathname, String] working_dir
  # @param [String] box
  # @param [TrueClass, FalseClass] verbose
  def initialize(working_dir, box, verbose)
    working_dir = Pathname.new(working_dir) unless working_dir.instance_of? Pathname
    @working_dir = working_dir
    @box = box
    @verbose = verbose
  end

  def reset
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
    ssh_close unless @ssh_connection.nil?
  end

  # @return [String]
  def status
    output = execute_local("vagrant status #{@box}")
    match_data = /^#{@box}\s+(.+?)\s+\(.+?\)$/.match(output)
    if match_data.nil?
      raise "Cannot detect machine status from output: `#{output}`."
    end
    match_data[1]
  end

  # @return [Hash]
  def ssh_options
    config = Tempfile.new('')
    execute_local("vagrant ssh-config #{@box} > #{config.path}")
    Net::SSH::Config.for(@box, [config.path])
  end

  # @return [Net::SSH::Connection::Session]
  def ssh_start
    if @ssh_connection.nil?
      options = ssh_options
      @ssh_connection = Net::SSH.start(options[:host_name], options[:user], options)
    end
    @ssh_connection
  end

  def ssh_close
    @ssh_connection.close
    @ssh_connection = nil
  end

  # @param [String] command
  # @return [String]
  def execute_ssh(command)
    channel = ssh_start.open_channel do |channel|
      channel.exec(command) do |ch, success|
        raise "could not execute command: #{command.inspect}" unless success
        ch[:output] = ''

        channel.on_data do |ch2, data|
          $stderr.print data if @verbose
          ch[:output] << data
        end

        channel.on_extended_data do |ch2, type, data|
          $stderr.print data if @verbose
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

  # @param [String, Array<String>] command
  # @param [Hash] env
  def execute_local(command, env = {})
    if @verbose
      $stderr.print command
      $stderr.print ' ' + env.to_s unless env.empty?
      $stderr.puts
    end

    # Reset bundler/rubygems environment, so that `vagrant` uses its own ruby environment
    env_override = env
    env = ENV.to_hash
    %w[BUNDLE_APP_CONFIG BUNDLE_CONFIG BUNDLE_GEMFILE BUNDLE_BIN_PATH RUBYLIB RUBYOPT GEMRC GEM_PATH].each do |var|
      env[var] = nil
    end
    env.merge!(env_override)
    cwd = @working_dir.to_s

    result = Komenda.run(command, {:env => env, :cwd => cwd})


    raise "Command execution failed:\n#{command}\n#{result.output}" unless result.success?
    result.stdout
  end

  # @param [Pathname, String] path
  # @return [Pathname]
  def parse_external_path(path)
    path = Pathname.new(path) unless path.instance_of? Pathname
    path = path.relative_path_from(@working_dir)
    raise 'Cannot parse path outside of working directory' if path.to_s.match(/^..\//)
    path.expand_path('/vagrant')
  end

  # @param [String] name
  # @param [String] version
  def install_plugin(name, version)
    unless execute_local('vagrant plugin list').match(/^#{name} \(#{version}\)$/)
      execute_local(['vagrant', 'plugin', 'install', name, '--plugin-version', version])
    end
  end
end
