module Puppet::Parser::Functions
  newfunction(:parse_apt_opts, :type => :rvalue) do |args|
    options = args[0]
    options.map! { |option| "-o #{option}" }.join(' ')
  end
end
