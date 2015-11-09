require 'rake'
require 'puppet-lint/tasks/puppet-lint'
require 'puppet-syntax/tasks/puppet-syntax'
require 'pathname'
require 'shellwords'
require 'json'

require './ruby/puppet_modules/spec_runner'
require './ruby/puppet_modules/finder'

PuppetLint.configuration.fail_on_warnings = true
PuppetLint.configuration.send('disable_arrow_alignment')
PuppetLint.configuration.send('disable_80chars')
PuppetLint.configuration.send('disable_documentation')
PuppetLint.configuration.send('disable_class_inherits_from_params_class')
PuppetLint.configuration.send('disable_parameter_order')
PuppetLint.configuration.ignore_paths = %w(**/templates/**/*.pp vendor/**/*.pp)

PuppetSyntax.exclude_paths = %w(**/templates/**/*.pp vendor/**/*.pp)

class SpecTask
  def self.run(specs)
    runner = PuppetModules::SpecRunner.new
    runner.on :output do |data|
      $stderr.print data
    end
    runner.add_specs(specs)
    result = runner.run
    puts result.summary
    exit(result.success?)
  end
end

root_dir = Pathname.new('./')
finder = PuppetModules::Finder.new(root_dir.join('modules'))

desc 'Run all specs'
task :spec do
  SpecTask.run(finder.specs)
end

namespace :spec do
  finder.modules.each do |puppet_module|
    specs = puppet_module.specs

    desc "Run #{puppet_module.name} specs"
    task puppet_module.name do
      SpecTask.run(specs)
    end

    next unless specs.length > 1
    specs.each do |spec|
      desc "Run #{spec.name} spec"
      task spec.name do
        SpecTask.run([spec])
      end
    end
  end

  desc 'Run all specs affected between `branch` and HEAD'
  task :changes_from_branch, [:branch] do |task, args|
    args.with_defaults(:branch => 'master')
    file_list = `git diff --name-only #{args.branch.shellescape}`.split("\n")
    module_list = file_list.map do |file|
      Regexp.last_match(1) if Regexp.new('^modules/(.+?)/').match(file)
    end
    module_list.compact!
    module_list.uniq!
    specs = module_list.map do |module_name|
      finder.get_module(module_name).specs
    end
    specs.flatten!
    SpecTask.run(specs)
  end

  task :cleanup do
    sh 'vagrant', 'halt', '--force'
  end
end
