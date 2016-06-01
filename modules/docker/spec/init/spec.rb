require 'spec_helper'

describe 'docker' do

  describe command('docker --version') do
    its(:exit_status) { should eq 0 }
  end

  describe service('docker') do
    it { should be_enabled }
    it { should be_running }
  end

end
