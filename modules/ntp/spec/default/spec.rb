require 'spec_helper'

describe 'ntp' do

  describe package('ntp') do
    it { should be_installed }
  end

  describe command('monit summary') do
    its(:stdout) { should match /ntp/ }
  end
end
