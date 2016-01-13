require 'spec_helper'

describe 'daemon' do

  describe service('my-program') do
    it { should be_enabled }
    it { should be_running }
  end

  describe command('monit summary') do
    its(:stdout) { should match /Program 'my-program'/ }
  end

  describe command('journalctl -u monit --no-pager') do
    its(:stdout) { should match /'my-program' '\/bin\/systemctl' failed with exit status \(3\)/ }
  end
end
