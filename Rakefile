require 'rake'
require 'rspec/core/rake_task'
require 'puppet-lint/tasks/puppet-lint'
require 'pathname'

PuppetLint.configuration.send("disable_arrow_alignment")

namespace :test do |ns|

  module_dirs = Pathname.new('modules/').children.select { |c| c.directory? }
  module_dirs.each do |module_dir|
    module_name = module_dir.basename
    RSpec::Core::RakeTask.new(module_name) do |t|
      t.pattern = "modules/#{module_name}/spec/*/*_spec.rb"
    end
  end

  RSpec::Core::RakeTask.new(:all) do |t|
    t.pattern = 'modules/*/spec/*/*_spec.rb'
  end
end

desc 'puppet validate'
task :validate do
  sh 'puppet parser validate $(find modules/ -name *.pp)'
end
