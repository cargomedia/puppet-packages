require 'json'
require 'pathname'
require 'yaml'

class PuppetSpec

  def initialize(vagrant_box, example_group)
    @vagrant_box = vagrant_box
    example_file = example_group.class.metadata[:block].source_location.first
    @spec_dir = Pathname.new(example_file).dirname
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

  def apply_manifests(debug)
    @spec_dir.entries.sort.each do |relative_path|
      next unless relative_path.extname == '.pp'

      manifest_path = relative_path.expand_path(@spec_dir)
      vagrant_manifest_path = @vagrant_box.parse_external_path(manifest_path)
      command = "sudo puppet apply --modulepath '/etc/puppet/modules:/vagrant/modules' #{vagrant_manifest_path.to_s.shellescape} --hiera_config=/etc/hiera.yaml"
      command += ' --verbose --debug --trace' if debug

      begin
        puts
        puts "Applying `#{vagrant_manifest_path.to_s}`"
        output = @vagrant_box.execute_ssh command
        output = output.gsub(/\e\[(\d+)(;\d+)*m/, '') # Remove color codes
        match = output.match(/^Error: .*$/)
        if match
          abort "Puppet command failed: `#{match[0]}`"
        end
      rescue Exception => e
        abort "Command failed: #{e.message}"
      end
    end
  end

end
