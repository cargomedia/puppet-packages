require 'spec_helper'

describe 'truecrypt' do

  describe command('truecrypt --help') do
    its(:exit_status) { should eq 0 }
  end
end
