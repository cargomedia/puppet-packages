require 'spec_helper'

describe 'php5::extension::timecop' do

  describe command('php --ri timecop') do
    its(:exit_status) { should eq 0 }
  end

  describe file('/var/log/php/error.log') do
    its(:content) { should_not match /Warning.*timecop.*already loaded/ }
  end
end
