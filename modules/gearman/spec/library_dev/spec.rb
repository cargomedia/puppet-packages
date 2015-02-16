require 'spec_helper'

describe 'gearman::library_dev' do

  describe package('libgearman7') do
    it { should be_installed }
  end

  describe package('libgearman-dev') do
    it { should be_installed }
  end
end
