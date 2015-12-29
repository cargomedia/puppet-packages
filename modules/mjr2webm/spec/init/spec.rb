require 'spec_helper'

describe 'mjr2webm::init' do

  describe command('mjr2webm') do
    its(:exit_status) { should eq 0 }
  end

end
