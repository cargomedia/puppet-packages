require 'spec_helper'

describe 'puppet::agent' do

  describe service('puppet') do
    it { should be_enabled }
    it { should be_running }
  end

  describe command('puppet agent --configprint server') do
    its(:stdout) { should match /^example.com$/ }
  end

  describe command('puppet agent --configprint runinterval') do
    its(:stdout) { should match /^120$/ }
  end

  describe command('puppet agent --configprint masterport') do
    its(:stdout) { should match /^8141$/ }
  end

  describe command('puppet agent --configprint splay') do
    its(:stdout) { should match /^true$/ }
  end

  describe command('puppet agent --configprint splaylimit') do
    its(:stdout) { should match /^120$/ }
  end

  describe command('puppet agent --configprint environment') do
    its(:stdout) { should match /^foo$/ }
  end

  describe command('sudo -u vagrant cat /opt/puppetlabs/puppet/cache/state/last_run_summary.yaml') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /puppet/ }
  end
end
