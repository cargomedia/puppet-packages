require 'serverspec'
require 'pathname'
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

  development = ENV['development']
  verbose = ENV['verbose'] || development
  debug = ENV['debug']
  vagrant_helper = VagrantHelper.new(verbose)

  c.add_setting :before_files
  c.before_files = []

  c.before :all do
    file = self.get_file
    unless c.before_files.include? file
      c.ssh.close if c.ssh
      c.before_files.push file

      vagrant_helper.prepare unless development
      c.ssh = vagrant_helper.connect

      manifests_dir = Dir.new Pathname.new(file).dirname
      vagrant_manifests_path = manifests_dir.to_path.sub(Dir.getwd, '/vagrant')
      manifests_dir.sort.each do |manifest|
        next unless File.extname(manifest) == '.pp'
        manifest_path = vagrant_manifests_path + '/' + manifest
        command = "sudo puppet apply --verbose --modulepath '/vagrant/modules' #{manifest_path.shellescape}"
        command += ' --debug' if debug
        begin
          vagrant_helper.exec command
        rescue Exception => e
          unless verbose
            $stderr.puts
            $stderr.puts 'Puppet: running manifest ' + manifest + ' failed!'
            $stderr.puts e.message
            $stderr.puts
          end
          abort 'Puppet command failed'
        end
      end
    end
  end
end