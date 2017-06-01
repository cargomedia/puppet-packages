require 'spec_helper'

describe 'fluentd::config' do

  describe service('fluentd') do
    it { should be_running }
  end

  describe file('/etc/fluentd/config.d/22-filter-my-rules-src1_remove_bar.conf') do
    it { should be_file }
    its(:content) { should match /filter src1\.\*\*/ }
    its(:content) { should match /@type grep/ }
  end

  describe file('/etc/fluentd/config.d/22-filter-my-rules-src1_keep_level_warn.conf') do
    it { should be_file }
    its(:content) { should match /filter src1\.\*\*/ }
    its(:content) { should match /@type grep/ }
  end

  describe file('/etc/fluentd/config.d/22-filter-my-rules-src2_remove_boo.conf') do
    it { should be_file }
    its(:content) { should match /filter src2\.\*\*/ }
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
                       hostname: /.+/,
                     )
    end
  end

  describe command('grep -rh toto /tmp/dump*') do
    its(:exit_status) { should eq 0 }
    its(:stdout) do
      is_expected.to include_json(
                       level: 'info',
                       message: 'toto',
                       unit: 'boo',
                       hostname: /.+/,
                     )
    end
  end

end
