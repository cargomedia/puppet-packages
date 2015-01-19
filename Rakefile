require 'rake'
require 'rspec/core/rake_task'
require 'puppet-lint/tasks/puppet-lint'
require 'puppet-syntax/tasks/puppet-syntax'
require 'pathname'
require 'shellwords'

PuppetLint.configuration.fail_on_warnings = true
PuppetLint.configuration.send('disable_arrow_alignment')
PuppetLint.configuration.send('disable_80chars')
PuppetLint.configuration.send('disable_documentation')
PuppetLint.configuration.send('disable_class_inherits_from_params_class')
PuppetLint.configuration.send('disable_parameter_order')
PuppetLint.configuration.ignore_paths = ["**/templates/**/*.pp", "vendor/**/*.pp"]

PuppetSyntax.exclude_paths = ["**/templates/**/*.pp", "vendor/**/*.pp"]

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
    specs = Dir.glob("#{module_dir}/spec/**/spec.rb")

    next if specs.empty?
    RSpec::Core::RakeTask.new(module_name) do |t|
      t.pattern = "modules/#{module_name}/spec/**/spec.rb"
    end

    next unless specs.count > 1
    namespace module_name.to_s do
      specs.each do |spec|
        specs_dir = "#{module_dir}/spec/"
        spec_path_relative = File.dirname(spec).sub(Regexp.new(specs_dir), '')
        spec_name = spec_path_relative.gsub('/', ':')

        RSpec::Core::RakeTask.new(spec_name) do |t|
          puts t.pattern = "modules/#{module_name}/spec/#{spec_path_relative}/spec.rb"
        end
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
    module_list.reject! { |mod| mod.nil? }
    module_list.uniq!

    RSpec::Core::RakeTask.new(:changes_from_branch_specs) do |t|
      t.pattern = "modules/{#{module_list.join(',')}}/spec/**/spec.rb"
    end
    Rake::Task[:changes_from_branch_specs].execute
  end
end
