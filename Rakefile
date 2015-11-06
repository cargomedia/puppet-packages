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


modules_dir = Pathname.new('modules/')
finder = PuppetModules::Finder.new(modules_dir)

desc 'Run all specs'
task :spec do
  runner = PuppetModules::SpecRunner.new(finder.specs)
  result = runner.run
  puts JSON.pretty_generate(result.summary)
end

namespace :spec do
  finder.modules.each do |puppet_module|
    specs = puppet_module.specs

    desc 'Run specs in ' + puppet_module.dir.to_s
    task puppet_module.name do
      runner = PuppetModules::SpecRunner.new(specs)
      result = runner.run
      puts JSON.pretty_generate(result.summary)
    end

    next unless specs.length > 1
    specs.each do |spec|
      desc 'Run spec ' + spec.file.to_s
      task spec.name do
        runner = PuppetModules::SpecRunner.new([spec])
        result = runner.run
        puts JSON.pretty_generate(result.summary)
      end
    end
  end
end
