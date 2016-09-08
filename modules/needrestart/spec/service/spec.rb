require 'spec_helper'

describe 'needrestart::service' do

  describe service('my-program1') do
    it { should be_running }
  end

  describe command('ls /tmp/my-program1-start-stamp-* | wc -l') do
    its(:stdout) { should match /1/ }
  end

  describe file('/etc/apt/apt.conf.d/99needrestart') do
    it { should_not be_file }
  end

end
