require 'spec_helper'

describe 'fluentd::config' do

  describe service('fluentd') do
    it { should be_running }
  end

  describe command('grep -e \'"message":"FOO"\' /tmp/dump1/*.log') do
    its(:exit_status) { should eq 0 }
  end
  describe command('grep -e \'"message"=>"FOO"\' /tmp/dump2/*.log') do
    its(:exit_status) { should eq 0 }
  end
end
