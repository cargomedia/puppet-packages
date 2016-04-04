require 'spec_helper'

describe 'daemon::daemon-kill' do

  describe service('my-program') do
    it { should be_enabled }
    it { should_not be_running }
  end
end
