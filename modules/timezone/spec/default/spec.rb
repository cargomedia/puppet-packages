require 'spec_helper'

describe 'timezone' do

  describe file('/etc/timezone') do
    its(:content) { should match /Etc\/UTC/ }
  end

  describe command('2>&1 dpkg-reconfigure -f noninteractive tzdata') do
    its(:stdout) { should match /default time zone.*Etc\/UTC/ }
  end
end
