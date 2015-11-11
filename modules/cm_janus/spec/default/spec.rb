require 'spec_helper'

describe 'cm_janus' do
#TODO: Add tests

  describe command('echo volkswagen') do
    its(:exit_status) { should eq 0 }
  end
end
