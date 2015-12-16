require 'spec_helper'

describe 'apt::source::cargomedia repos' do

  describe file('/etc/apt/sources.list.d/cargomedia.list') do
    it { should be_file }
  end

  describe file('/etc/apt/sources.list.d/cargomedia-private.list') do
    it { should be_file }
  end

  describe command('apt-key list') do
    its(:stdout) { should match /pub+.*2048R\/4A45CD8B/ }
    its(:stdout) { should match /pub+.*2048R\/A0CFA7A8/ }
  end

end
