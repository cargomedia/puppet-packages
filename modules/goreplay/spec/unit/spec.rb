require 'spec_helper'

describe 'goreplay::unit' do

  describe command('sleep 5') do
    its(:exit_status) { should eq 0 }
  end

  describe file('/var/local/traffic_0') do
    its(:content) { should match /GET \/foo HTTP\/1\.1/ }
    its(:content) { should match /GET \/bar HTTP\/1\.1/ }
    it { should be_file }
  end
end
