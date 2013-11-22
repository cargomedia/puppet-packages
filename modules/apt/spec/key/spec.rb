require 'spec_helper'

describe command('apt-key list') do
  its(:stdout) { should match /^pub\s+\w+\/7BD9BF62\s+/ }
  its(:stdout) { should match /^pub\s+\w+\/EEA14886\s+/ }
end
