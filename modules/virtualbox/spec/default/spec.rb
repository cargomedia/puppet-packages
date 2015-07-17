require 'spec_helper'

describe 'virtualbox' do

  describe command('virtualbox -?') do
    its(:exit_status) { should eq 0 }
  end

end
