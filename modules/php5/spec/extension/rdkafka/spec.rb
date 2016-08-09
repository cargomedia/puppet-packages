require 'spec_helper'

describe 'rdkafka' do

  describe command('php --re rdkafka | grep \'rdkafka version\'') do
    its(:exit_status) { should eq 0 }
  end
end
