require 'fileutils'
require 'shellwords'

module Puppet::Parser::Functions
  newfunction(:generate_sshkey, :type => :rvalue) do |args|
    name = args[0]
    key_file = "/opt/puppetlabs/puppet/cache/ssh-repository/#{name}"
    unless File.exists? key_file
      FileUtils.mkdir_p File.dirname key_file
      unless Kernel.system("/usr/bin/ssh-keygen -q -t ssh-rsa -N '' -f #{Shellwords.escape(key_file)} -C #{Shellwords.escape(name)}")
        raise Puppet::ParseError, "Failed to generate SSH key `#{name}`."
      end
    end
    private = File.read(key_file)
    public = File.read(key_file + '.pub')
    {'private' => private, 'public' => public}
  end
end
