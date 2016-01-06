require 'spec_helper'

describe 'mjr_convert::init' do

  describe command('which mjr2webm') do
    its(:exit_status) { should eq 0 }
  end

  describe command('which mjr2png') do
    its(:exit_status) { should eq 0 }
  end

end
