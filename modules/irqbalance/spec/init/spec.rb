require 'spec_helper'

describe 'irqbalance' do

  describe package('irqbalance') do
    it { should be_installed }
  end
end
