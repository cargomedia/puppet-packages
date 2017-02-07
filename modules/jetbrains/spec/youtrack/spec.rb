require 'spec_helper'

describe 'jetbrains-youtrack' do

  describe service('jetbrains-youtrack') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(80) do
    it { should be_listening }
  end

  describe port(443) do
    it { should be_listening }
  end

  describe port(8082) do
    it { should be_listening }
  end

end
