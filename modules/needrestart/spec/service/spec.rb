require 'spec_helper'

describe 'needrestart::service' do

  describe service('my-program') do
    it { should be_running }
  end

  # check if restarted after upgraded?

end
