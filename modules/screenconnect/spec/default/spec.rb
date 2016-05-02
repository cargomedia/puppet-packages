require 'spec_helper'

describe 'screenconnect' do

  describe command('pgrep -f screenconnect') do
    its(:exit_status) { should eq 0 }
  end

end
