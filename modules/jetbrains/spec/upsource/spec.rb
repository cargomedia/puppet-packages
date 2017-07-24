require 'spec_helper'

describe 'jetbrains-upsource' do

  describe service('jetbrains-upsource') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(80) do
    it { should be_listening }
  end

  describe port(443) do
    it { should be_listening }
  end

  describe port(8083) do
    it { should be_listening }
  end

  describe file('/usr/local/jetbrains-upsource/conf/internal/bundle.properties') do
    its(:content) { should match /^hub-url=https\\:\/\/localhost\\:8081\/hub$/ }
    its(:content) { should match /^disable.hub=true$/ }
  end

end
