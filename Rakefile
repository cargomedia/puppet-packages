require 'rake'
require 'puppet-lint/tasks/puppet-lint'
require 'puppet-syntax/tasks/puppet-syntax'
require 'pathname'
require 'shellwords'

require 'komenda'
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


namespace :spec do

  modules_dir = Pathname.new('modules/')
  finder = PuppetModules::Finder.new(modules_dir)

  finder.modules.each do |puppet_module|
    specs = puppet_module.specs

    desc 'Run specs in ' + puppet_module.dir.to_s
    task puppet_module.name do
      runner = PuppetModules::SpecRunner.new(specs)
      runner.run
    end

    next unless specs.length > 1
    specs.each do |spec|
      desc 'Run spec ' + spec.file.to_s
      task spec.name do
        runner = PuppetModules::SpecRunner.new([spec])
        runner.run
      end
    end
  end
end
