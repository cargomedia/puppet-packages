require 'serverspec'
require 'docker'
require 'lib/box'
require 'lib/puppet'

RSpec.configure do |configuration|

  dir_root = File.expand_path('../../', __FILE__)
  debug = ENV['debug']
  keep_box = ENV['keep_box'] # todo
  box_name = ENV['box']
  box = Box.new(dir_root)

  configuration.raise_errors_for_deprecations!

  docker_image = Docker::Image.build_from_dir("#{dir_root}/spec/docker/#{box_name}/")

  Specinfra.configuration.backend = :docker
  Specinfra.configuration.docker_image = docker_image.id
  Specinfra.configuration.docker_container_create_options = {
    'HostConfig' => {
      'Binds' => [
        box.dir_outside.to_s + ':' + box.dir_inside.to_s,
        "#{dir_root}/spec/.proxy_cache:/tmp/proxy-cache"
      ]
    }
  }
  Specinfra.configuration.docker_container_exec_options = {
  }

  def start_debug
    interactive_debug = true

    if interactive_debug
      puts "Something went wrong..."
      # todo: print error information
      container_id = Specinfra.backend.instance_variable_get(:@container).id
      puts 'Run the following command to attach to the running container:'
      puts "  sudo docker exec -it #{container_id} bash"
      sleep(1000)
      # todo: ask user to retry operation, or continue
    end
  end

  configuration.before :all do
    puppet = Puppet.new(box, self, debug)
    puppet.apply_facts
    puppet.configure_hiera

    begin
      puppet.apply_manifests
    rescue => e
      start_debug
      raise e
    end
  end

  configuration.around(:each) do |example|
    begin
      example.run
      raise if example.exception
    rescue => e
      start_debug
    end
  end
end
