require 'spec_helper'

describe 'php5::extension::spl_types' do

  describe command('php --ri spl_types') do
    its(:exit_status) { should eq 0 }
  end
end
