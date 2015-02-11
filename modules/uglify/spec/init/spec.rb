require 'spec_helper'

describe 'uglify' do

  describe package('uglify-js') do
    it { should be_installed.by('npm') }
  end
end
