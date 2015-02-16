require 'spec_helper'

describe 'php5::extension::mongo' do

  describe command('php --ri mongo') do
    its(:exit_status) { should eq 0 }
  end

  describe file('/var/log/php/error.log') do
    its(:content) { should_not match /Warning.*mongo.*already loaded/ }
  end
end
