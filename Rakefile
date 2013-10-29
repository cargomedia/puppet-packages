require 'rake'
require 'rspec/core/rake_task'
require 'puppet-lint/tasks/puppet-lint'
require 'pathname'

PuppetLint.configuration.send('disable_arrow_alignment')

RSpec::Core::RakeTask.new(:test) do |t|
  t.pattern = 'modules/*/spec/*/spec.rb'
end

namespace :test do
  task :cleanup do
    sh 'vagrant', 'halt', '--force'
  end

  module_dirs = Pathname.new('modules/').children.select { |c| c.directory? }
  module_dirs.each do |module_dir|
    module_name = module_dir.basename
    specs = Dir.glob("#{module_dir}/spec/*/spec.rb")

    next if specs.empty?
    RSpec::Core::RakeTask.new(module_name) do |t|
      t.pattern = "modules/#{module_name}/spec/*/spec.rb"
    end

    next unless specs.count > 1
    namespace module_name.to_s do
      specs.each do |spec|
        spec_name = File.basename File.dirname spec
        RSpec::Core::RakeTask.new(spec_name) do |t|
          puts t.pattern = "modules/#{module_name}/spec/#{spec_name}/spec.rb"
        end
      end
    end
  end
end

desc 'puppet validate'
task :validate do
  sh 'puppet parser validate $(find modules/ -name *.pp)'
end
