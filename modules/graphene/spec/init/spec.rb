require 'spec_helper'

describe 'graphene' do

  describe package('graphene') do
    it { should_be installed }
  end
end
