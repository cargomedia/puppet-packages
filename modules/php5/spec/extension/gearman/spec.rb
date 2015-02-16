require 'spec_helper'

describe 'php5::extension::gearman' do

  describe command('php --ri gearman') do
    its(:exit_status) { should eq 0 }
  end

  describe file('/var/log/php/error.log') do
    its(:content) { should_not match /Warning.*gearman.*already loaded/ }
  end
end
