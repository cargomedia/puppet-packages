require 'fileutils'
require 'shellwords'

module Puppet::Parser::Functions
  newfunction(:generate_sshkey, :type => :rvalue) do |args|
    name = args[0]
    key_file = "/var/lib/puppet/ssh-repository/#{name}"
    unless File.exists? key_file
      FileUtils.mkdir_p File.dirname key_file
      `/usr/bin/ssh-keygen -t ssh-rsa -f #{Shellwords.escape(key_file)} -C #{Shellwords.escape(name)}`
    end
    private = File.read(key_file)
    public = File.read(key_file + '.pub')
    {'private' => private, 'public' => public}
  end
end
