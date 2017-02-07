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

end
