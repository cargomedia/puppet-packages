require 'spec_helper'

describe 'php5::extension::gd' do

  describe command('php --ri gd') do
    its(:exit_status) { should eq 0 }
  end
end
