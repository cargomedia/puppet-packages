require 'json'
require 'pathname'
require 'yaml'

class Puppet

  # @param [VagrantBox] vagrant_box
  # @param [RSpec::Core::ExampleGroup] example_group
  # @param [TrueClass, FalseClass] verbose
  def initialize(vagrant_box, example_group, verbose)
    @vagrant_box = vagrant_box
    example_file = example_group.class.metadata[:block].source_location.first
    @spec_dir = Pathname.new(example_file).dirname
    @verbose = verbose
  end

  def configure_hiera
    hiera_config = {
        'version' => 5,
        'defaults' => {
            'data_hash' => 'json_data'
        },
        'hierarchy' => [
            {
                'name' => 'spec configuration',
                'path' => @spec_dir.join('hiera.json').relative_path_from(@vagrant_box.working_dir).to_s,
            },
            {
                'name' => 'global configuration',
                'path' => 'spec/hiera.json',
            }
        ]
    }
    hiera_config_command = "echo #{hiera_config.to_yaml.shellescape} > /etc/hiera.yaml"
    @vagrant_box.execute_ssh("sudo bash -c #{hiera_config_command.shellescape}")

    hiera_path = @spec_dir.join('hiera.json')
    if hiera_path.file?
      $stderr.puts "Hiera variables present: #{JSON.parse(hiera_path.read)}"
    end
  end

  def apply_facts
    facts_path = @spec_dir.join('facts.json')
    if facts_path.file?
      $stderr.puts "Facts present: #{JSON.parse(facts_path.read)}"
      vagrant_facts_path = @vagrant_box.parse_external_path(facts_path)
      @vagrant_box.execute_ssh("sudo mkdir -p /etc/facter/facts.d && sudo ln -sf #{vagrant_facts_path.to_s.shellescape} /etc/facter/facts.d/")
    end
  end

  def apply_manifests
    @spec_dir.entries.sort.each do |relative_path|
      next unless relative_path.extname == '.pp'
      run_apply(relative_path.expand_path(@spec_dir))
    end
  end

  private

  # @param [Pathname] manifest_path
  def run_apply(manifest_path)
    manifest_path_vagrant = @vagrant_box.parse_external_path(manifest_path)
    module_path = '/etc/puppetlabs/code/modules:/vagrant/modules'
    hiera_path = '/etc/hiera.yaml'

    command = "sudo puppet apply --basemodulepath #{module_path.shellescape} --hiera_config=#{hiera_path.shellescape}"
    command += ' --verbose --debug --trace' if @verbose
    command += ' ' + manifest_path_vagrant.to_s.shellescape
    command += ' --detailed-exitcodes || [ $? -eq 2 ]'

    begin
      $stderr.puts "Puppet applying: `#{manifest_path_vagrant.to_s}`"
      @vagrant_box.execute_ssh command
    rescue Exception => e
      raise "Puppet apply failed: #{e.message}"
    end
  end

end
