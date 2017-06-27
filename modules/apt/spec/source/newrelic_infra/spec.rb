require 'spec_helper'

describe 'apt::source::newrelic_infra' do

  describe file('/etc/apt/sources.list.d/newrelic-infra.list') do
    it { should be_file }
  end

  describe command('apt-key list') do
    its(:stdout) { should match /pub+.*4096R\/8ECCE87C/ }
    its(:stdout) { should match /<infrastructure-eng@newrelic.com>/ }
  end

end
