require 'spec_helper'

describe 'php5::extension::redis' do

  describe command('php --ri redis') do
    its(:exit_status) { should eq 0 }
  end

  describe file('/var/log/php/error.log') do
    its(:content) { should_not match /Warning.*redis.*already loaded/ }
  end
end
