require 'spec_helper'

describe 'fs::config' do

  describe command('tune2fs -l /dev/sda1 | grep -qE "^Maximum mount count+.+-1$"') do
    its(:exit_status) { should eq 0 }
  end

  describe file('/var/local/nofsck') do
    it { should be_file }
  end
end
