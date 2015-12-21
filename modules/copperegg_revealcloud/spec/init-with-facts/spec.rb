require 'spec_helper'

describe 'copperegg_revealcloud' do

  describe process('revealcloud') do
    it { should be_running }
    its(:args) { should match '-t fact-tag-foo' }
  end

end
