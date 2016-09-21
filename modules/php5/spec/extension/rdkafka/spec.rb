require 'spec_helper'

describe 'php5::extension::rdkafka' do

  describe package('librdkafka-dev') do
    it { should be_installed }
  end

  describe command('php --re rdkafka | grep \'rdkafka version\'') do
    its(:exit_status) { should eq 0 }
  end
end
