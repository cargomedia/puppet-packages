require 'spec_helper'

describe 'php5::extension::imagick' do

  describe command('php --ri imagick') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /imagick\.progress_monitor => 1 => 1/}
  end

  describe file('/var/log/php/error.log') do
    its(:content) { should_not match /Warning.*imagick.*already loaded/ }
  end
end
