require 'spec_helper'

describe 'copperegg_revealcloud' do

  describe process('revealcloud') do
    it { should be_running }
    its(:args) { should match '-t custom1' }
    its(:args) { should match '-t custom2' }
    its(:args) { should match '-t hiera1' }
    its(:args) { should match '-t hiera2' }
    its(:args) { should match '-t facts1' }
    its(:args) { should match '-t facts2' }
  end

end
