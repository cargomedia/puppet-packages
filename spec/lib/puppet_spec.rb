require 'json'
require 'pathname'
require 'yaml'

class PuppetSpec

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
      :backends => ['json'],
      :json => {
        :datadir => '/vagrant'
      },
      :hierarchy => [
        @spec_dir.join('hiera').relative_path_from(@vagrant_box.working_dir).to_s,
        'spec/hiera'
      ]
    }
    hiera_config_command = "echo #{hiera_config.to_yaml.shellescape} > /etc/hiera.yaml"
    @vagrant_box.execute_ssh("sudo bash -c #{hiera_config_command.shellescape}")

    hiera_path = @spec_dir.join('hiera.json')
    if hiera_path.file?
      puts "Hiera variables present: #{JSON.parse(hiera_path.read)}"
    end
  end

  def apply_facts
    facts_path = @spec_dir.join('facts.json')
    if facts_path.file?
      puts "Facts present: #{JSON.parse(facts_path.read)}"
      vagrant_facts_path = @vagrant_box.parse_external_path(facts_path)
      @vagrant_box.execute_ssh("sudo mkdir -p /etc/facter/facts.d && sudo ln -sf #{vagrant_facts_path.to_s.shellescape} /etc/facter/facts.d/")
    end
  end

  def apply_manifests
    @spec_dir.entries.sort.each do |relative_path|
      next unless relative_path.extname == '.pp'

      manifest_path = relative_path.expand_path(@spec_dir)
      manifest_path_vagrant = @vagrant_box.parse_external_path(manifest_path)
      run_apply_manifest(manifest_path_vagrant)
    end
  end

  private

  # @param [Pathname] path
  def run_apply_manifest(path)
    run_apply(path.to_s.shellescape)
  end

  # @param [String] puppet_code
  def run_apply_code(puppet_code)
    run_apply("--execute #{puppet_code.shellescape}")
  end

  # @param [String] arg
  def run_apply(arg)
    module_path = '/etc/puppet/modules:/vagrant/modules'
    hiera_path = '/etc/hiera.yaml'

    command = "sudo puppet apply --modulepath #{module_path.shellescape} --hiera_config=#{hiera_path.shellescape}"
    command += ' --verbose --debug --trace' if @verbose
    command += ' ' + arg
    command += ' --detailed-exitcodes || [ $? -eq 2 ]'

    begin
      puts "Puppet applying: `#{arg.to_s}`"
      @vagrant_box.execute_ssh command
    rescue Exception => e
      abort "Command failed: #{e.message}"
    end
  end

end
