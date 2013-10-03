require 'rake'
require 'rspec/core/rake_task'
require 'puppet-lint/tasks/puppet-lint'

namespace :test do

  task :prepare do
    at_exit { Rake::Task['test:cleanup'].invoke }
  end

  task :cleanup do
    sh 'vagrant', 'halt', '--force'
  end

  RSpec::Core::RakeTask.new(:nfs) do |t|
    t.pattern = 'modules/nfs/spec/*/*_spec.rb'
  end
  task :nfs => :prepare

  desc 'puppet validate and puppet-lint'
  task :lint do
    sh 'puppet parser validate $(find modules/ -name *.pp)'

    PuppetLint.configuration.send("disable_arrow_alignment")
    Rake::Task['lint'].invoke
  end

end
