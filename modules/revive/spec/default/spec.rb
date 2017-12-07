require 'spec_helper'

describe 'revive' do

  describe port(80) do
    it { should be_listening }
  end

  describe port(443) do
    it { should be_listening }
  end

  describe command('env no_proxy=example.com curl http://example.com -v') do
    its(:stderr) { should match 'Location: https://example.com/' }
  end

  describe command('env no_proxy=example.com curl https://example.com -Lk') do
    its(:stdout) { should match 'Revive Adserver' }
  end
end
