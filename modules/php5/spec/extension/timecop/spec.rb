require 'spec_helper'

describe 'php5::extension::timecop' do

  describe command('php --ri timecop') do
    its(:exit_status) { should eq 0 }
  end
end
