require 'spec_helper'

describe 'monit::entry real' do

  describe file('/etc/monit/conf.d/filesystem') do
    it { should be_file }
  end
end
