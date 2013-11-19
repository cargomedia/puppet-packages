require 'serverspec'
require 'net/ssh'
require 'vagrant_helper'
require 'yaml'

include Serverspec::Helper::Ssh
include Serverspec::Helper::DetectOS

module RSpec
  module Core
    class ExampleGroup
      def get_file
        block = self.class.metadata[:example_group_block]
        if RUBY_VERSION.start_with?('1.8')
          file = block.to_s.match(/.*@(.*):[0-9]+>/)[1]
        else
          file = block.source_location.first
        end
        file
      end
    end
  end
end

RSpec.configure do |c|

  debug = ENV['debug']
  c.add_setting :before_files
  c.before_files = []
  vagrant_helper = VagrantHelper.new(Dir.getwd, true)

  c.before :all do
    file = self.get_file
    unless c.before_files.include? file
      c.before_files.push file
      c.ssh.close if c.ssh

      vagrant_helper.reset
      c.ssh = vagrant_helper.connect
      spec_dir = Dir.new File.dirname file

      if File.exists? spec_dir.to_path + '/facts.json'
        vagrant_facts_path = vagrant_helper.get_path spec_dir.to_path + '/facts.json'
        vagrant_helper.exec("sudo mkdir -p /etc/facter/facts.d && sudo ln -sf #{vagrant_facts_path.shellescape} /etc/facter/facts.d/")
      end

      hiera_config = {
          :backends => ['json'],
          :hierarchy => ['hiera'],
          :json => {
              :datadir => vagrant_helper.get_path(spec_dir.to_path)
          }
      }
      hiera_config_content = hiera_config.to_yaml.gsub('!ruby/sym ', ':')
      hiera_command = "echo #{hiera_config_content.shellescape} > /etc/hiera.yml"
      vagrant_helper.exec("sudo bash -c #{hiera_command.shellescape}")

      spec_dir.sort.each do |local_file|
        next unless File.extname(local_file) == '.pp'
        vagrant_manifest_path = vagrant_helper.get_path spec_dir.to_path + '/' + local_file
        command = "sudo puppet apply --verbose --modulepath '/etc/puppet/modules:/vagrant/modules' #{vagrant_manifest_path.shellescape} --hiera_config=/etc/hiera.yml"
        command += ' --debug' if debug
        begin
          puts
          puts 'Running `' + vagrant_manifest_path + '`'
          output = vagrant_helper.exec command
          raise output if output.match(/Error: /)
        rescue Exception => e
          abort 'Puppet command failed'
        end
      end
    end
  end
end
