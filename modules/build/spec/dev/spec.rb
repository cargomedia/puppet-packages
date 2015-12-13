require 'spec_helper'

describe 'build::dev' do

  describe package('zlib1g-dev') do
    it { should be_installed }
  end

end
