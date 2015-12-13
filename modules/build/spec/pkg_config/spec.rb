require 'spec_helper'

describe 'build::pkg_config' do

  describe package('pkg-config') do
    it { should be_installed }
  end

end
