require 'spec_helper'

describe 'postgresql::server' do

  describe service('postgresql') do
    it { should be_running }
  end

  describe port(1234) do
    it { should be_listening }
  end

end
