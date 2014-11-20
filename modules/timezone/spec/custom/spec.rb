require 'spec_helper'

describe file('/etc/timezone') do
  its(:content) { should match /Europe\/Berlin/ }
end

describe command('2>&1 dpkg-reconfigure -f noninteractive tzdata') do
  its(:stdout) { should match /Current default time zone:.*Europe\/Berlin/ }
end
