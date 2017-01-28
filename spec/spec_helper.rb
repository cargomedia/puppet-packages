require 'serverspec'
require 'lib/box'
require 'lib/puppet'

RSpec.configure do |configuration|

  debug = ENV['debug']
  keep_box = ENV['keep_box'] # todo
  box_name = ENV['box'] # todo
  box = Box.new(Dir.getwd)

  configuration.raise_errors_for_deprecations!

  Specinfra.configuration.backend = :docker
  Specinfra.configuration.docker_image = 'cargomedia/base:v1'
  Specinfra.configuration.docker_container_create_options = {
    'HostConfig' => {
      'Binds' => [
        box.dir_outside.to_s + ':' + box.dir_inside.to_s
      ]
    }
  }

  configuration.before :all do
    puppet = Puppet.new(box, self, debug)
    puppet.apply_facts
    puppet.configure_hiera
    puppet.apply_manifests
  end
end
