require 'spec_helper'

describe 'php5::extension::mongodb' do

  describe command('php --ri mongodb') do
    its(:exit_status) { should eq 0 }
  end
end
