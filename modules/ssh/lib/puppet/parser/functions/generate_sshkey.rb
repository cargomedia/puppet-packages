require 'fileutils'
require 'shellwords'

module Puppet::Parser::Functions
  newfunction(:generate_sshkey, :type => :rvalue) do |args|
    key_file = args[0]
    unless File.exists? key_file
      FileUtils.mkdir_p File.dirname key_file
      `/usr/bin/ssh-keygen -t ssh-rsa -f #{Shellwords.escape(key_file)}`
    end
    private = File.read(key_file)
    public = File.read(key_file + '.pub').match(/ssh-rsa ([^\s]+)/)[1]
    {'private' => private, 'public' => public}
  end
end
