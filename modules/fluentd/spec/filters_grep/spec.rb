require 'spec_helper'

describe 'fluentd::config' do

  describe service('fluentd') do
    it { should be_running }
  end

  describe file('/etc/fluentd/config.d/22-filter-my-rules_remove_bar.conf') do
    it { should be_file }
    its(:content) { should match /filter \*\*/ }
    its(:content) { should match /@type grep/ }
  end

  describe file('/etc/fluentd/config.d/22-filter-my-rules_keep_level_warn.conf') do
    it { should be_file }
    its(:content) { should match /filter \*\*/ }
    its(:content) { should match /@type grep/ }
  end

  describe command('grep -r bar /tmp/dump*') do
    its(:exit_status) { should eq 1 }
  end

  describe command('grep -rh foo /tmp/dump*') do
    its(:exit_status) { should eq 0 }
    its(:stdout) do
      is_expected.to include_json(
                       level: 'warning',
                       message: 'foo',
                     )
    end
  end

end
