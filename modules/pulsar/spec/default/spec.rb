require 'spec_helper'

describe 'pulsar' do

  describe command('pulsar --version') do
    it { should return_exit_status 0 }
  end
end
