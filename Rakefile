require 'rake'
require 'puppet-lint/tasks/puppet-lint'

PuppetLint.configuration.send("disable_hard_tabs")
PuppetLint.configuration.send("disable_2sp_soft_tabs")

task :default => [:lint]
