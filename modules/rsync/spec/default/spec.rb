require 'spec_helper'

describe 'rsync' do

  describe package('rsync') do
    it { should be_installed }
  end

end
