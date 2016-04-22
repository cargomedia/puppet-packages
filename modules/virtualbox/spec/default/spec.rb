require 'spec_helper'

describe 'virtualbox' do

  describe command('virtualbox -?') do
    its(:exit_status) { should eq 0 }
  end

  describe file('/usr/local/bin/deleteAllVirtualboxVms') do
    it { should be_file }
    it { should be_executable }
  end

end
