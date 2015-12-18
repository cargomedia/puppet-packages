require 'spec_helper'

describe 'copperegg_revealcloud' do

  describe command('2>&1 /usr/local/revealcloud/revealcloud -V') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match 'RevealCloud' }
  end

  describe service('revealcloud') do
    it { should be_running }
    it { should be_enabled }
  end

  describe process('revealcloud') do
    it { should be_running }
    its(:args) { should match '-k my_key' }
    its(:args) { should match '-l foo' }
    its(:args) { should match '-t tag1 -t tag2' }
  end

end
