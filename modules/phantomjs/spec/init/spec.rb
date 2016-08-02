require 'spec_helper'

describe 'phantomjs' do

  describe package('phantomjs-prebuilt') do
    it { should be_installed.by('npm') }
  end

  describe command('phantomjs --version') do
    its(:exit_status) { should eq 0 }
  end
end
