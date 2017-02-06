require 'spec_helper'

describe 'jetbrains-hub' do

  describe service('jetbrains-hub') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(80) do
    it { should be_listening }
  end

  describe port(443) do
    it { should be_listening }
  end

  describe command('env no_proxy=example.com curl http://example.com -v') do
    its(:stderr) { should match 'Location: https://example.com/' }
  end

  describe command('env no_proxy=example.com curl https://example.com/main.js -Lk') do
    its(:stdout) { should match 'JetBrains Hub' }
  end

end
