require 'spec_helper'

describe 'fluentd' do

  describe command('fluentd --version') do
    its(:exit_status) { should eq 0 }
  end

  describe service('fluentd') do
    it { should be_running }
  end

  describe port(24220) do
    it { should be_listening }
  end

end
