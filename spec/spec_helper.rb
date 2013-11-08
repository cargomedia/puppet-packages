require 'serverspec'
require 'net/ssh'
require 'vagrant_helper'

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

      manifests_dir = Dir.new File.dirname file
      manifests_dir.sort.each do |manifest|
        next unless File.extname(manifest) == '.pp'
        vagrant_manifest_path = vagrant_helper.get_path manifests_dir.to_path + '/' + manifest
        command = "sudo puppet apply --verbose --modulepath '/vagrant/modules' #{vagrant_manifest_path.shellescape}"
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