require 'puppet/provider/package'
require 'json'

Puppet::Type.type(:package).provide :npm, :parent => Puppet::Provider::Package do
  desc "npm is package management for node.js. This provider only handles global packages."

  has_feature :versionable, :package_settings

  if Puppet::Util::Package.versioncmp(Puppet.version, '3.0') >= 0
    has_command(:npm, 'npm') do
      is_optional
      environment :HOME => "/root"
    end
  else
    optional_commands :npm => 'npm'
  end

  def self.npmlist
    # Ignore non-zero exit codes as they can be minor, just try and parse JSON
    output = execute([command(:npm), 'list', '--json', '--global'], {:combine => false})
    Puppet.debug("Warning: npm list --json exited with code #{$CHILD_STATUS.exitstatus}") unless $CHILD_STATUS.success?
    begin
      # ignore any npm output lines to be a bit more robust
      output = PSON.parse(output.lines.select { |l| l =~ /^((?!^npm).*)$/ }.join("\n"), {:max_nesting => 100})
      @npmlist = output['dependencies'] || {}
    rescue PSON::ParserError => e
      Puppet.debug("Error: npm list --json command error #{e.message}")
      @npmlist = {}
    end
  end

  def npmlist
    self.class.npmlist
  end

  def self.instances
    @npmlist ||= npmlist
    @npmlist.collect do |k, v|
      new({:name => k, :ensure => v['version'], :provider => 'npm'})
    end
  end

  def query
    list = npmlist

    if list.has_key?(resource[:name]) and list[resource[:name]].has_key?('version')
      version = list[resource[:name]]['version']
      {:ensure => version, :name => resource[:name]}
    else
      {:ensure => :absent, :name => resource[:name]}
    end
  end

  def latest
    output = npm('view', resource[:name], 'versions', '--json', '--quiet', '--registry', registry)
    versions = JSON.parse(output)
    versions.last
  end

  def update
    self.install
  end

  def install
    if resource[:ensure].is_a? Symbol
      package = resource[:name]
    else
      package = "#{resource[:name]}@#{resource[:ensure]}"
    end

    package = resource[:source] if resource[:source]
    npm('install', '--global', package, '--registry', registry)
  end

  def uninstall
    npm('uninstall', '--global', resource[:name])
  end

  def package_settings
    @resource[:package_settings]
  end

  def package_settings_insync?(should, is)
    is.sort == should.sort
  end

  def package_settings=(value)
    @resource[:package_settings] = value
  end

  def registry
    settings = @resource[:package_settings]
    (settings && settings['registry']) ? settings['registry'] : 'https://registry.npmjs.org/'
  end
end
