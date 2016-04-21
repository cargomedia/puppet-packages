require 'spec_helper'

describe 'uglify' do

  describe package('uglify-js') do
    it { should be_installed.by('npm') }
  end

  describe command('uglifyjs --version') do
    its(:exit_status) { should eq 0 }
  end

end
