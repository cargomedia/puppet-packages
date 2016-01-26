require 'spec_helper'

describe 'daemon' do

  describe service('my-program') do
    it { should be_enabled }
    it { should be_running }
  end

  describe command("monit summary | grep -E 'Pro.+my-program.+[Running|ok]'") do
    its(:exit_status) { should eq 0 }
  end
end
