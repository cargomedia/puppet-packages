require 'rake'
require 'puppet-lint/tasks/puppet-lint'
require 'puppet-syntax/tasks/puppet-syntax'
require 'pathname'
require 'shellwords'
require 'json'

require './spec/lib/finder'
require './spec/lib/spec_runner'

PuppetLint.configuration.fail_on_warnings = true
PuppetLint.configuration.send('disable_arrow_alignment')
PuppetLint.configuration.send('disable_80chars')
PuppetLint.configuration.send('disable_140chars')
PuppetLint.configuration.send('disable_documentation')
PuppetLint.configuration.send('disable_class_inherits_from_params_class')
PuppetLint.configuration.send('disable_parameter_order')
PuppetLint.configuration.send('disable_variable_is_lowercase')
PuppetLint.configuration.send('disable_arrow_on_right_operand_line')
PuppetLint.configuration.ignore_paths = %w(**/templates/**/*.pp vendor/**/*.pp)

PuppetSyntax.exclude_paths = %w(**/templates/**/*.pp vendor/**/*.pp)

class SpecRunnerTask
  def self.execute(specs)
    runner = PuppetModules::SpecRunner.new
    runner.on :output do |data|
      $stderr.print data
    end
    runner.filter_os_list = ENV['os'].split(/,\s*/) if ENV['os']
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
  SpecRunnerTask.execute(finder.specs)
end

namespace :spec do
  finder.puppet_modules.each do |puppet_module|
    specs = puppet_module.specs

    desc "Run #{puppet_module.name} specs"
    task puppet_module.name do
      SpecRunnerTask.execute(specs)
    end

    next unless specs.length > 1
    specs.each do |spec|
      desc "Run #{spec.name} spec"
      task spec.name do
        SpecRunnerTask.execute([spec])
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
    module_list.select! { |module_name| finder.puppet_module?(module_name) }
    specs = module_list.map do |module_name|
      finder.puppet_module(module_name).specs
    end
    specs.flatten!
    SpecRunnerTask.execute(specs)
  end

  task :cleanup do
    Komenda.run(['vagrant', 'halt', '--force'], fail_on_fail: true)
  end
end
