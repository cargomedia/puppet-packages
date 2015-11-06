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
PuppetLint.configuration.ignore_paths = ["**/templates/**/*.pp", "vendor/**/*.pp"]

PuppetSyntax.exclude_paths = ["**/templates/**/*.pp", "vendor/**/*.pp"]

root_dir = Pathname.new('./')
os_support = JSON.parse(root_dir.join('operatingsystem_support.json').read)
runner = PuppetModules::SpecRunner.new(os_support)
finder = PuppetModules::Finder.new(root_dir.join('modules'))

desc 'Run all specs'
task :spec do
  runner.add_specs(finder.specs)
  result = runner.run
  puts result.summary
end

namespace :spec do
  finder.modules.each do |puppet_module|
    specs = puppet_module.specs

    desc 'Run specs in ' + puppet_module.dir.to_s
    task puppet_module.name do
      runner.add_specs(specs)
      result = runner.run
      puts result.summary
    end

    next unless specs.length > 1
    specs.each do |spec|
      desc 'Run spec ' + spec.file.to_s
      task spec.name do
        runner.add_specs([spec])
        result = runner.run
        puts result.summary
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
    module_list.reject!(&:nil?)
    module_list.uniq!
    module_list.each do |module_name|
      specs = finder.get_module(module_name).specs
      runner.add_specs(specs)
    end
    runner.run
  end
end
