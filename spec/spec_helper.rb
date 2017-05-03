require 'serverspec'
require 'docker'
require 'lib/box'
require 'lib/puppet'

RSpec.configure do |configuration|

  debug = ENV['debug']
  keep_box = ENV['keep_box'] # todo
  box_name = ENV['box'] # todo
  box = Box.new(Dir.getwd)

  configuration.raise_errors_for_deprecations!

  docker_dir = File.expand_path("../../spec/docker/#{box_name}/", __FILE__)
  docker_image = Docker::Image.build_from_dir(docker_dir)

  Specinfra.configuration.backend = :docker
  Specinfra.configuration.docker_image = docker_image.id
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
