require 'spec_helper'

describe 'php5::extension::runkit' do

  describe command('php --ri runkit') do
    its(:exit_status) { should eq 0 }
  end
end
