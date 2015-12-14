require 'spec_helper'

describe 'graphene' do

  describe package('graphene') do
    it { should be_installed }
  end
end
