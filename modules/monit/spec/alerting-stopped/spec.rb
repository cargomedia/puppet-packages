require 'spec_helper'

describe 'monit alerting' do

  describe command('/etc/init.d/monit stop') do
    its(:exit_status) { should eq 0 }
  end

  describe process('monit') do
    it { should_not be_running }
  end

  describe command('monit-alert none') do
    its(:exit_status) { should eq 0 }
  end

end
