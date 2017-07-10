require 'spec_helper'

describe 'blackmagic::desktopvideo' do

  describe package('desktopvideo') do
    it { should be_installed }
  end

  describe kernel_module('blackmagic') do
    it { should be_loaded }
  end

  describe kernel_module('blackmagic_io') do
    it { should be_loaded }
  end
end
