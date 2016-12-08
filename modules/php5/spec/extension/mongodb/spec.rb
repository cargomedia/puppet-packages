require 'spec_helper'

describe 'php5::extension::mongodb' do

  describe command('php --ri mongodb') do
    its(:exit_status) { should eq 0 }
  end

  describe file('/var/log/php/error.log') do
    its(:content) { should_not match /Warning.*mongodb.*already loaded/ }
  end
end
