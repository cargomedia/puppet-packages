require 'serverspec'
require 'pathname'
require 'net/ssh'

include Serverspec::Helper::Ssh
include Serverspec::Helper::DetectOS

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

      vagrantIsRunning = `vagrant status`.match(/running/)
      vagrantHasSnapshot = `vagrant snapshot list`.match(/Name: default-test-snapshot /)

      actions = []
      unless vagrantHasSnapshot
        actions.push('destroy -f')
        actions.push('up')
        actions.push('snapshot take default default-test-snapshot')
      end
      unless vagrantIsRunning
        actions.push('up')
      end
      actions.push('snapshot go default default-test-snapshot')
      actions.each do |action|
        `vagrant #{action}`
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

      manifest = File.join(Pathname.new(file).dirname, 'manifest.pp')
      manifest = manifest.sub(Dir.getwd, '/vagrant')
      provisioner = "sudo puppet apply --detailed-exitcodes --verbose --modulepath '/vagrant/modules' #{manifest.shellescape} || [ $? -eq 2 ]"
      c.ssh.exec!(provisioner)
    end
  end
end
