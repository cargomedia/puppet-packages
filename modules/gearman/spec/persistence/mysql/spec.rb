require 'spec_helper'

describe 'gearman persistence sqlite' do

  describe file('/etc/default/gearman-job-server') do
    it { should be_file }
    its(:content) { should match /--queue-type=mysql/ }
  end

  describe service('gearman-job-server') do
    it { should be_running }
  end

  describe port(4730) do
    it { should be_listening }
  end

end
