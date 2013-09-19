require 'hiera'

module Puppet::Parser::Functions
  newfunction(:hiera_lookup, :type => :rvalue) do |args|
    certname = args[0]
    key = args[1]

    uri = URI.parse('http://localhost:8080/v2/nodes/' + certname + '/facts')
    result = Net::HTTP.get(uri)
    puppetdbFacts = JSON.parse(result)

    facts = {}
    puppetdbFacts.each do |fact|
      name = '::' + fact['name']
      value = fact['value']
      facts[name] = value
    end

    hiera = Hiera.new(:config => HieraPuppet.hiera_config)
    hiera.lookup(key, 'default', facts)
  end
end
