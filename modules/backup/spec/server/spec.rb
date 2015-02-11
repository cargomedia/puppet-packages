require 'spec_helper'

describe 'backup::server' do

  describe package('rdiff-backup') do
    it { should be_installed }
  end
end
