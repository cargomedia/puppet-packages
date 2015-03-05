require 'spec_helper'

describe 'copperegg_revealcloud' do

  describe file('/etc/init.d/revealcloud') do
    it { should be_file }
    its(:content) { should match '-t fact-tag-foo' }
  end
end
