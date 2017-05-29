require 'serverspec'
require 'rspec/json_expectations'
require 'lib/vagrant'
require 'lib/puppet'

RSpec.configure do |configuration|

  debug = ENV['debug']
  keep_box = ENV['keep_box']
  box = ENV['box']
  root_dir = Dir.getwd
  vagrant = Vagrant.new(root_dir, box, true)

  configuration.raise_errors_for_deprecations!

  configuration.before :all do

    vagrant.reset unless keep_box
    puppet = Puppet.new(vagrant, self, debug)
    puppet.apply_facts
    puppet.configure_hiera
    puppet.apply_manifests

    Specinfra.configuration.backend = :ssh
    Specinfra.configuration.ssh_options = vagrant.ssh_options
    Specinfra.configuration.ssh = vagrant.ssh_start
  end
end
