require 'spec_helper'

describe 'gentrans' do

  describe package('gentrans') do
    it { should_be installed }
  end
end
