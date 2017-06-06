module Puppet::Parser::Functions
  newfunction(:grep_rules, :type => :rvalue, :doc => <<-EOS
    Return lists of filter_grep rules
  EOS
  ) do |args|
    grep_rules = args[0]
    filter_options = args[1]

    Hash[
      grep_rules.map do |rules|
        ["#{filter_options['name']}_#{rules[0]}", {
          :pattern => filter_options['pattern'],
          :priority => filter_options['priority'],
          :type => 'grep',
          :config => rules[1],
        }]
      end
    ]
  end
end
