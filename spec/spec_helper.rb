require 'serverspec'
require 'lib/vagrant_box'
require 'lib/puppet_spec'

RSpec.configure do |configuration|

  debug = ENV['debug']
  keep_box = ENV['keep_box']
  box = ENV['box'] || 'wheezy'
  root_dir = Dir.getwd
  vagrant_box = VagrantBox.new(root_dir, box, true)

  configuration.before :all do

    vagrant_box.reset unless keep_box
    Specinfra.configuration.backend = :ssh
    Specinfra.configuration.ssh_options = vagrant_box.ssh_options
    Specinfra.configuration.ssh = vagrant_box.ssh_start

    puppet_spec = PuppetSpec.new(vagrant_box, self, debug)

    puppet_spec.apply_facts
    puppet_spec.configure_hiera
    puppet_spec.apply_manifests
  end
end
