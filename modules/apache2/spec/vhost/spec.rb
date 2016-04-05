require 'spec_helper'

describe 'apache2::vhost' do

  describe service('apache2') do
    it { should be_running }
  end

  describe port(1234) do
    it { should be_listening }
  end

end
