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
    its(:stdout) { should match /^1234$/ }
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

  describe command('puppet agent --configprint lastrunfile') do
    its(:stdout) { should match('/opt/puppetlabs/puppet/cache/state/last_run_summary.yaml') }
  end

  describe file('/opt/puppetlabs/puppet/cache/state/last_run_summary.yaml') do
    it { should be_file }
    its(:content) { should match /version:/ }
    it { should be_readable.by('others') }
  end

  describe command('/opt/puppetlabs/puppet/bin/gem list') do
    its(:stdout) { should match('deep_merge') }
    its(:stdout) { should match('i18n') }
  end

end
