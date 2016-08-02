require 'spec_helper'

describe 'loggly_github' do

  describe service('loggly-github') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(1234) do
    it { should be_listening }
  end

end
