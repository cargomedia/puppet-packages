require 'spec_helper'

describe 'browserify' do

  describe package('browserify-js') do
    it { should be_installed.by('npm') }
  end
end
