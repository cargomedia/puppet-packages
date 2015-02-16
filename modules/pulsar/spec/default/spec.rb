require 'spec_helper'

describe 'pulsar' do

  describe command('pulsar --version') do
    its(:exit_status) { should eq 0 }
  end
end
