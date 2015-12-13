require 'spec_helper'

describe 'build::libtool' do

  describe package('libtool') do
    it { should be_installed }
  end

end
