require 'spec_helper'

describe 'php5::extension::ssh2' do

  describe command('php --ri ssh2') do
    its(:exit_status) { should eq 0 }
  end

  describe file('/var/log/php/error.log') do
    its(:content) { should_not match /Warning.*ssh2.*already loaded/ }
  end
end
