require 'spec_helper'

describe 'php5::extension::stats' do

  describe command('php --ri stats') do
    its(:exit_status) { should eq 0 }
  end
end
