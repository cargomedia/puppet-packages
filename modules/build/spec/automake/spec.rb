require 'spec_helper'

describe 'build::automake' do

  describe package('automake') do
    it { should be_installed }
  end

end
