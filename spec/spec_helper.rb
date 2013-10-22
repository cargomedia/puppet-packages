require 'serverspec'
require 'pathname'
require 'net/ssh'
require 'term/ansicolor'

include Serverspec::Helper::Ssh
include Serverspec::Helper::DetectOS
include Term::ANSIColor

RSpec.configure do |c|
  if ENV['ASK_SUDO_PASSWORD']
    require 'highline/import'
    c.sudo_password = ask("Enter sudo password: ") { |q| q.echo = false }
  else
    c.sudo_password = ENV['SUDO_PASSWORD']
  end
  c.before :all do
    block = self.class.metadata[:example_group_block]
    if RUBY_VERSION.start_with?('1.8')
      file = block.to_s.match(/.*@(.*):[0-9]+>/)[1]
    else
      file = block.source_location.first
    end
    pwd = Pathname.new(file).dirname
    c.add_setting :pwd
    if c.pwd != pwd
      c.pwd = pwd
      c.ssh.close if c.ssh

      vagrant_is_running = `vagrant status`.match(/running/)
      vagrant_has_snapshot = system('vagrant snapshot list 2>/dev/null | grep -q "Name: default "')

      actions = []
      unless vagrant_has_snapshot
        actions.push('destroy -f')
        actions.push('up')
        actions.push('snapshot take default')
      end
      unless vagrant_is_running
        actions.push('up')
      end
      actions.push('snapshot go default')
      actions.each do |action|
        #`vagrant #{action}`
      end

      user = Etc.getlogin
      options = {}
      config = `vagrant ssh-config`
      config.each_line do |line|
        if match = /HostName (.*)/.match(line)
          c.host = match[1]
          options = Net::SSH::Config.for(c.host)
        elsif  match = /User (.*)/.match(line)
          user = match[1]
        elsif match = /IdentityFile (.*)/.match(line)
          options[:keys] = [match[1].gsub(/"/, '')]
        elsif match = /Port (.*)/.match(line)
          options[:port] = match[1]
        end
      end
      c.ssh = Net::SSH.start(c.host, user, options)


      manifests_dir = Dir.new Pathname.new(file).dirname
      vagrant_manifests_path = manifests_dir.to_path.sub(Dir.getwd, '/vagrant')
      manifests_dir.sort.each do |manifest_path|
        next unless File.extname(manifest_path) == '.pp'
        manifest = vagrant_manifests_path + '/' + manifest_path
        command = "sudo puppet apply --detailed-exitcodes --verbose --modulepath '/vagrant/modules' #{manifest.shellescape}"
        channel = c.ssh.open_channel do |channel|
          channel.exec(command) do |ch, success|
            raise "could not execute command: #{command.inspect}" unless success
            ch[:output] = ''

            channel.on_data do |ch2, data|
              ch[:output] << data
            end

            channel.on_extended_data do |ch2, type, data|
              ch[:output] << data
            end

            channel.on_request "exit-status" do |ch, data|
              ch[:success] = (data.read_long == 0)
            end
          end
        end
        channel.wait
        unless channel[:success]
          puts
          puts on_red white 'Puppet command failed!'
          puts
          puts channel[:output]
          puts
          exit
        end
      end
    end
  end
end
