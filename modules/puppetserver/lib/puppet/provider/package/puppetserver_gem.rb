Puppet::Type.type(:package).provide :puppetserver_gem, :parent => :gem do
  has_feature :versionable, :install_options

  confine :exists => '/opt/puppetlabs/bin/puppetserver', :for_binary => true

  def self.command(name)
    return ['/opt/puppetlabs/bin/puppetserver', 'gem'] if name == :gemcmd
    super
  end

end
