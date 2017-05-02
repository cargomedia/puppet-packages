require 'spec_helper'

describe 'fs::config::nofsck' do

  describe command('tune2fs -l /dev/sda1') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /^Check interval+.+\(<none>\)$/}
    its(:stdout) { should match /^Maximum mount count+.+-1$/}
  end
end
