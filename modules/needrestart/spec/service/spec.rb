require 'spec_helper'

describe 'needrestart::service' do

  describe service('my-program') do
    it { should be_running }
  end

  describe command('ls /tmp/my-program-start-stamp-* | wc -l') do
    its(:stdout) { should match /1/ }
  end

end
