require 'spec_helper'

describe 'percona_toolkit' do

  describe package('percona-toolkit') do
    it { should be_installed }
  end

  describe command('pt-online-schema-change --version') do
    its(:stdout) { should match '2.2.11' }
  end
end
