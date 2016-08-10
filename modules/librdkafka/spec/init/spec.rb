require 'spec_helper'

describe 'librdkafka' do

  describe package('librdkafka-dev') do
    it { should be_installed }
  end
end
