require 'spec_helper'

describe command('which phpunit') do
  its(:exit_status) { should eq 0 }
end

describe command('phpunit --version') do
  its(:stdout) { should match /3\.7\.27/ }
end
