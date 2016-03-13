require 'spec_helper'

describe 'composer' do

  describe command('which composer') do
    its(:exit_status) { should eq 0 }
  end

end
