require 'spec_helper'

describe 'lame' do

  describe command('lame --version') do
    its(:exit_status) { should eq 0 }
  end
end
