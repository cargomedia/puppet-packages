require 'spec_helper'

describe 'monit::entry real' do

  describe file('/etc/monit/conf.d/puppet') do
    it { should be_file }
  end
end
